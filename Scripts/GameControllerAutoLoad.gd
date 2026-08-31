extends Node

var satellites : Array[Satellite]
#starts at -1 as the start of the game will increment it
var level_index : int = -1
var death_counter : int = 0
var completed_levels : Array[bool] = []
var levels : Array[String] = [
	"res://Scenes/Levels/level_1.tscn",
	"res://Scenes/Levels/level_2.tscn",
	"res://Scenes/Levels/level_3.tscn",
	"res://Scenes/Levels/level_4.tscn",
	"res://Scenes/Levels/level_5.tscn",
	"res://Scenes/Levels/level_77.tscn",
	"res://Scenes/Levels/level_6.tscn",
	"res://Scenes/Levels/level_7.tscn",
	"res://Scenes/Levels/level_8.tscn",
	"res://Scenes/Levels/level_10.tscn",
	"res://Scenes/Levels/level_11.tscn",
	"res://Scenes/Levels/level_900.tscn",
	"res://Scenes/Levels/level_12.tscn",
	"res://Scenes/Levels/level_13.tscn",
	
	"res://Scenes/level_test.tscn",]
var current_level : Node2D = null
var next_level : PackedScene

signal start_fade_out

@onready var space: Node2D = $"../Space"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHandler.next_level.connect(_prepare_next_level)
	SignalHandler.index_level.connect(_load_level_from_index)

	for level in levels:
		completed_levels.append(false)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func check_win() -> void:
	for satellite in satellites:
		if not satellite.dead:
			return
	SignalHandler.win.emit(death_counter)
	completed_levels[level_index] = true

func load_level() -> void:
	satellites = []
	death_counter = 0
	print("loading level ",level_index," into scene")
	if current_level != null:
		current_level.queue_free()
	current_level = next_level.instantiate()
	space.add_child(current_level)
	SignalHandler.level_loaded.emit()

func _load_level_from_index(index:int):
	level_index = index
	call_deferred("prepare_level")

func _prepare_next_level():
	if level_index < levels.size():
		level_index +=1
	next_level = load(levels[level_index])
	call_deferred("prepare_level")

func prepare_level():
	print("loading level ",level_index," from disk")
	next_level = load(levels[level_index])
	start_fade_out.emit()

	
