extends Area2D
class_name GravitationalMass

@export var gravityStrength : float = 1.0
@export var gravityRange : float

@onready var moon: Area2D = $"../Our Moon"

var distanceToMoon : float
var directionFromMoon : Vector2
var gravitationPull: Vector2
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	gravitationPull = get_force_to_body(moon)
	moon.add_velocity(gravitationPull * delta)

func get_force_to_body(body:Node2D) -> Vector2:
	
	var dis_to_body = abs(global_position-body.global_position).length()
	var force = maxf(gravityRange-dis_to_body,0) * gravityStrength
	return (global_position-body.global_position).normalized() * force
