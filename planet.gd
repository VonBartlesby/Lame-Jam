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
	distanceToMoon = abs(position-moon.position).length()
	#print(distanceToMoon)
	if distanceToMoon < gravityRange:
		gravitationPull = (gravityRange-distanceToMoon)*gravityStrength
		print("pulling at strength ",gravitationPull)
		moon.add_velocity((position-moon.position).normalized() * gravitationPull * delta)
