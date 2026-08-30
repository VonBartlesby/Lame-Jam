extends ColorRect

var is_fade_out : bool = false
var fade_out : bool = false
var fade_in : bool = false
var target : float = 1.0
var fading : bool = false
var fade_speed : float = 1.0
@onready var main_menu: Node2D = $"../.."



func _ready() -> void:
	SignalHandler.level_loaded.connect(_start_fade_in)
	GameControllerAutoLoad.start_fade_out.connect(_start_fade_out)
	_start_fade_in()

func _process(delta: float) -> void:
	if fading:
		color.a = lerpf(color.a,target,delta * fade_speed)
		if is_fade_out && color.a >1:
			fading = false
			GameControllerAutoLoad.load_level()
			main_menu.on_fade_fin()
		elif not is_fade_out && color.a < 0.0:
			fading = false
		
func _start_fade_in():
	target = -0.1
	fading = true
	is_fade_out = false
	fade_speed = 0.8

func _start_fade_out():
	target = 1.1
	fading = true
	is_fade_out = true
	fade_speed = 2
