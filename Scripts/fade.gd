extends ColorRect

var fade : bool = false
var target : float = 1.0
@onready var main_menu: Node2D = $"../.."


# Called when the node enters the scene tree for the first time.
signal fade_fin

func _ready() -> void:
	color.a = 0.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fade:
		color.a = lerpf(color.a,target,delta * 3)
		if color.a >= target * 0.95 && target == 1:
			main_menu._on_fade_fin()
			target = 0
		elif color.a <= 0.05 && target == 0:
			fade = false
			SignalHandler.fade_fin.emit()

func _on_button_button_up() -> void:
	fade = true
