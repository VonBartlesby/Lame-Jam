extends Node2D

@onready var main_menu: Node2D = $"Main Menu"
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var parallaxes: Node2D = $parallaxes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHandler.level_loaded.connect(_on_level_load)

	for child in get_children():
		if not child is Parallax2D:
			child.visible = false
	main_menu.visible = true
	canvas_layer.visible = true
	parallaxes.visible = true
	

func _on_level_load() -> void:
	for child in get_children():
		child.visible = true
