extends Button

var level_index:int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level_index = get_index()
	text = "Level " + str(level_index)
	connect("pressed", select_level)

func select_level():
	#SignalHandler.emit_signal("next_level")
	if GameControllerAutoLoad.level_index != level_index: #dont load current level
		GameControllerAutoLoad.load_level_index(level_index)
	else:
		SignalHandler.emit_signal("reset")
