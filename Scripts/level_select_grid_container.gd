extends GridContainer

var levels = GameControllerAutoLoad.levels

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var count = 0
	for level in levels:
		var button = LevelSelectButton.new()
		button.text = "Level %d" % [count + 1]
		button.level_index = count
		add_child(button)
		count += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
