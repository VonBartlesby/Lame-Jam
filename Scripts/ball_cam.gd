extends Camera2D
class_name Cam
@export var ball : Ball
@export var zoom_speed : float = 2.0

var follow_speed = 4

var zoom_level : float = 1. : 
	set(z):
		z = clamp(z,0.25,2.)
		zoom_level=z
		
func _ready() -> void:
	offset=ball.global_position
	SignalHandler.drift_off.connect(_on_drift_off)
	SignalHandler.reset.connect(_on_reset)
	SignalHandler.level_loaded.connect(_on_reset)
	
func _process(delta: float) -> void:
	offset = lerp(offset,ball.global_position,delta*follow_speed)
	var im_just_lerpin = lerp(zoom.x,zoom_level,delta * zoom_speed)
	zoom = Vector2(im_just_lerpin,im_just_lerpin)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("ui_up"):
		zoom_level += 0.25
	if event.is_action("ui_down"):
		zoom_level -= 0.25

func _on_drift_off():
	follow_speed = 0

func _on_reset():
	follow_speed = 4
