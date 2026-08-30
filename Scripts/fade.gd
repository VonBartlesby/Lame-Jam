extends ColorRect

var fade : bool = false
var target : float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color.a = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fade:
		color.a = lerpf(color.a,target,delta * 5)


func _on_button_button_up() -> void:
	fade = true
