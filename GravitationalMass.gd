@tool
extends Area2D
class_name GravitationalMass

@export var size = 1.0
@export var debug : bool = false

var gravityStrength : float = 1.0

const BASE_GRAVITY_STRENGTH = 4000000



@onready var moon: Ball = $"../../Our Moon"


var distanceToMoon : float
var directionFromMoon : Vector2
var gravitationPull: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gravityStrength = BASE_GRAVITY_STRENGTH * size * size
	scale = Vector2.ONE * size



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if not Engine.is_editor_hint():
		gravitationPull = get_force_to_body(moon)
		if moon.started:
			moon.add_velocity(gravitationPull * delta)
	elif debug:
		gravityStrength = BASE_GRAVITY_STRENGTH * size
		scale = Vector2.ONE * size


func get_force_to_body(body:Node2D) -> Vector2:
	var dis_to_body = abs(global_position-body.global_position).length()
	var inverse_square = 1/(dis_to_body*dis_to_body)
	var force = inverse_square * gravityStrength
	if force < 40:
		force =  0
	return (global_position-body.global_position).normalized() * force
