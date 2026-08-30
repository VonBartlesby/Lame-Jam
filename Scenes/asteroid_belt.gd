@tool
extends Node2D

@export_range(0,1000,1) var asteroid_amount : int = 50
@export_range(0,5,0.1) var density : float = 1.0
@export_range(0,1000,1) var size : float = 50
@export var reroll : bool = false
@export var save : bool = false


const ASTEROID = preload("uid://c3tnp3dhi7dno")

var last_count
var last_size
var last_density

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	last_count = asteroid_amount
	last_size = size
	last_density = density
	print("ready")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	var while_count = 0
	if Engine.is_editor_hint():
		if last_count != asteroid_amount or last_size != size or last_density != density or reroll:
			reroll = false
			for child in get_children():
				child.queue_free()
			for i in range(1,asteroid_amount):
				var new_asteroid = ASTEROID.instantiate(PackedScene.GenEditState.GEN_EDIT_STATE_INSTANCE)
				#add_child(new_asteroid)
				var too_close = true
				while_count = 0
				var while_max = 100
				var pos
				if get_children().size() == 0:
					add_child(new_asteroid)
				else:
					while too_close:
						while_count += 1
						pos = position.from_angle(randf_range(0,2) * PI) * randf_range(0,size)
						too_close = false
						for child in get_children():
							if (child.position - pos).length() < 10 * density:
								too_close = true
						if while_count > while_max:
							print("escaped")
							too_close = false
				add_child(new_asteroid)
				new_asteroid.position = pos

		last_count = asteroid_amount
		last_size = size
		last_density = density
		
		if save:
			save = false
			for child in get_children():
				child.owner = self
	

func fill_shape():
	pass
