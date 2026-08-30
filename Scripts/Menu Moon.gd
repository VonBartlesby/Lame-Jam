extends Node2D

@onready var button: Button = $"../Camera2D/CanvasLayer/Button"
var move = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button.connect("button_up",_on_begin_button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if move:
		position = position.lerp(get_viewport_rect().size * Vector2(1,-1),delta)

func _on_begin_button():
	move = true
