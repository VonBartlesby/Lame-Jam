@tool
extends Area2D

@export_range(10,300) var orbit_offset : int = 150
@export_range(-1,1) var orbit_speed : float = 0.1
@export_range(0,360) var start_rotation : float = 0.0
@export var stationary : bool = false


var planet : GravitationalMass
var orbit_center : Vector2
var orbit_distance : float
var start : Vector2
var time : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_parent() is GravitationalMass:
		SignalHandler.reset.connect(_reset)
		planet = get_parent()
		orbit_center = planet.position
		orbit_distance = planet.size * orbit_offset
		start = position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if get_parent() is GravitationalMass:
		planet = get_parent()
		time += delta * orbit_speed
		if abs(time) > 2:
			time = 0
		
		var vec = Vector2.from_angle((PI * time) + deg_to_rad(start_rotation)) * orbit_distance + planet.global_position
		rotation = (PI * time)
		global_position = vec

func _reset():
	if get_parent() is GravitationalMass:
		orbit_distance = planet.size * orbit_offset
		time = 0
