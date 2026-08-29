extends Area2D

@export var gravityStrength : float = 1.0
@export var gravityRange : float

@onready var moon: Area2D = $"../Our Moon"

var distanceToMoon : float
var directionFromMoon : Vector2
var gravitationPull: float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	gravitationPull = get_force_to_body(moon)
	moon.add_velocity((position-moon.position).normalized() * gravitationPull * delta)

func get_force_to_body(body:Node2D) -> float:
	var dis_to_body = abs(position-body.position).length()
	return maxf(gravityRange-dis_to_body,0) * gravityStrength
