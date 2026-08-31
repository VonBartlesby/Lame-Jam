extends Camera2D
class_name Cam
@export var ball : Ball
@export var zoom_speed : float = 2.0

@export var screen_shake_multi = 0.2
var shake_strength:float = 0.0
var shake:Vector2 = Vector2(0,0)


var time:float = 0.0

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
	
	SignalHandler.impacted.connect(shake_camera_impact)
	SignalHandler.launched.connect(shake_camera_launch)
	SignalHandler.reflected.connect(shake_camera_reflect)
	SignalHandler.destroy_satellite.connect(shake_camera_destroy_satellite)
	SignalHandler.destroy_asteroid.connect(shake_camera_destroy_asteroid)
	SignalHandler.spaghettified.connect(shake_camera_spaghettified)
	
func _process(delta: float) -> void:
	time += delta
	var s = shake * screen_shake_multi
	offset = lerp(offset + s,ball.global_position + s,delta*follow_speed)
	rotation = (sin(time * 20) * shake_strength * 0.002) * screen_shake_multi
	var im_just_lerpin = lerp(zoom.x,zoom_level,delta * zoom_speed)
	zoom = Vector2(im_just_lerpin,im_just_lerpin)
	
	shake_strength = lerp(shake_strength, 0.0, delta * 3)
	
	shake = Vector2(sin(time * 40.33) * shake_strength, cos(time*32.82) * shake_strength)
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventPanGesture:
		zoom_level -= (event.delta.y * 0.1)
		
	if event.is_action("ui_up"):
		zoom_level += 0.1
	if event.is_action("ui_down"):
		zoom_level -= 0.1

func _on_drift_off():
	follow_speed = 0

func _on_reset():
	follow_speed = 4
	if (global_position - ball.global_position).length() > 100:
		offset = ball.global_position

func shake_camera(magnitude):
	shake_strength += magnitude
	
func shake_camera_impact():
	shake_camera(16)
	follow_speed = 8
	await get_tree().create_timer(1).timeout
	follow_speed = 4
	
func shake_camera_reflect():
	shake_camera(2)
	
func shake_camera_launch():
	shake_camera(8)
	
func shake_camera_spaghettified():
	shake_camera(8)
	
func shake_camera_destroy_satellite():
	shake_camera(4)
	
func shake_camera_destroy_asteroid():
	shake_camera(1)
