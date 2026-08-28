extends Camera2D
class_name Cam
@export var ball : Ball


var zoom_level : float = 1. : 
	set(z):
		z = clamp(z,0.25,2.)
		zoom_level=z
		zoom=Vector2(z,z)
func _ready() -> void:
	offset=ball.global_position
func _process(delta: float) -> void:
	offset = lerp(offset,ball.global_position,delta*4.)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("ui_up"):
		zoom_level += 0.25
	if event.is_action("ui_down"):
		zoom_level -= 0.25
