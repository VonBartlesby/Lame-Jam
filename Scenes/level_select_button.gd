extends Button
class_name LevelSelectButton
var level_index:int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_up.connect(select_level)

func select_level():
	SignalHandler.index_level.emit(level_index)
