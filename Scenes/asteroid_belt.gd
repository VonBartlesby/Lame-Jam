@tool
extends Node2D

@export_range(0,1000,1) var asteroid_amount : int = 50




@export_range(0,1000,0.1) var size : float = 50

@export var reroll : bool = false
@export var save : bool = false
@export_group("Mode Settings")
@export var ring_mode:bool = false
@export_subgroup("Random Mode")
@export_range(0,5,0.1) var density : float = 1.0

@export_subgroup("Ring Mode")
@export_range(0,20,1) var rings : int = 1
@export_range(0,50,0.1) var size_start : float = 20
@export var add : float = 0.1


const ASTEROID = preload("uid://c3tnp3dhi7dno")

var last_count
var last_size
var last_size_start
var last_rings
var last_add
var last_density

# Called when the node enters the scene tree for the first time.

func _ready() -> void:
	last_count = asteroid_amount
	last_size = size
	last_density = density
	print("ready")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if Engine.is_editor_hint():
		if last_count != asteroid_amount or last_size != size or last_size_start != size_start or last_density != density or last_rings != rings or last_add != add or reroll:
			reroll = false
			for child in get_children():
				child.queue_free()
			if ring_mode:
				generate_rings()
			else:
				generate_field()

		last_count = asteroid_amount
		last_size = size
		last_size_start = size_start
		last_density = density
		last_rings = rings
		last_add = add
		
		if save:
			save = false
			for child in get_children():
				child.owner = self
	

func generate_field():
	var while_count = 0
	for i in range(1,asteroid_amount):
		var new_asteroid = ASTEROID.instantiate(PackedScene.GenEditState.GEN_EDIT_STATE_INSTANCE)
		#add_child(new_asteroid)
		var too_close = true
		while_count = 0
		var while_max = 1
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
	
func generate_rings():
	
	for i in range(1,asteroid_amount):
		var new_asteroid = ASTEROID.instantiate(PackedScene.GenEditState.GEN_EDIT_STATE_INSTANCE)
		#add_child(new_asteroid)
		var pos
		if get_children().size() == 0:
			add_child(new_asteroid)
		else:
			var step = int(rings) % asteroid_amount 
			var angle = i * (2*PI) / (asteroid_amount / step)
			var q =  i * add
			var x = cos(angle + q) * ((i % step) + (size_start/2))
			var y = sin(angle + q) * ((i % step) + (size_start/2))
			pos = Vector2(x,y) * (size - size_start)
			#pos = position.from_angle(PI * deg_to_rad(i / asteroid_amount))
			#for child in get_children():
				#if (child.position - pos).length() == 0:
					#return
					#too_close = true
			#if while_count > while_max:
				#print("escaped")
				#too_close = false
		add_child(new_asteroid)
		new_asteroid.position = pos
	
func fill_shape():
	pass
