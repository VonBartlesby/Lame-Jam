extends Node

var satellites : Array[Satellite]
var level_index : int = 0
var levels : Array[String] = [
	"uid://dfu5uonpag3ao",
	"uid://b4o7xngl6brmt",]
var current_level : Node2D = null
var next_level : PackedScene


@onready var space: Node2D = $"../Space"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHandler.next_level.connect(_load_next_level)
	next_level = load(levels[level_index])
	current_level = next_level.instantiate()
	call_deferred("load")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func check_win() -> void:
	for satellite in satellites:
		if not satellite.dead:
			return
	SignalHandler.win.emit()

func load() -> void:
	satellites = []
	
	space.add_child(current_level)
	SignalHandler.level_loaded.emit()
	level_index += 1
	if level_index < levels.size():
		next_level = load(levels[level_index])

func _load_next_level():
	space.clear_level()
	current_level = next_level.instantiate()
	call_deferred("load")
