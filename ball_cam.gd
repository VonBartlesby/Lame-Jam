extends Camera2D
class_name Cam
@export var ball : Ball
@export var zoom_speed : float = 2.0

var zoom_level : float = 1. : 
	set(z):
		z = clamp(z,0.25,2.)
		zoom_level=z
func _ready() -> void:
	offset=ball.global_position
	
func _process(delta: float) -> void:
	offset = lerp(offset,ball.global_position,delta*4.)
	var im_just_lerpin = lerp(zoom.x,zoom_level,delta * zoom_speed)
	zoom = Vector2(im_just_lerpin,im_just_lerpin)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("ui_up"):
		zoom_level += 0.25
	if event.is_action("ui_down"):
		zoom_level -= 0.25
