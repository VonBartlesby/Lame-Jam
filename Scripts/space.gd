extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHandler.fade_fin.connect(_on_fade_fin)
	SignalHandler.level_loaded.connect(_on_level_load)
	for child in get_children():
		if not child is Parallax2D:
			child.visible = false
	get_child(-1).visible = true
	get_child(4).visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	

func _on_fade_fin() -> void:
	for child in get_children():
		child.visible = true

func _on_level_load() -> void:
	if not get_child(2).visible:
		get_child(-1).visible = false
