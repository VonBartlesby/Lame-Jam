extends GridContainer

var levels = GameControllerAutoLoad.levels
const GAME_THEME = preload("uid://c7iw7wjbt70ov")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var count = 0
	for level in levels:
		var button = LevelSelectButton.new()
		button.text = "Level %d" % [count + 1]
		button.level_index = count
		button.theme = GAME_THEME
		button.add_theme_font_size_override("font size",8)
		add_child(button)
		count += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
