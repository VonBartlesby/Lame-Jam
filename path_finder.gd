extends Node2D

@export var look_ahead_time : float = 2

@onready var our_moon: Ball = $".."
@onready var masses: Node2D = $"../../Masses"

@onready var reset_button: Button = $"../../Ui Controller/ResetButton"


var velocity : Vector2 = Vector2.ZERO
var speed : float = 1.0
var planets_in_range = []
var global_lock :Vector2
var loops : int



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	loops = look_ahead_time * 60 as int
	reset_button.connect("button_up",_reset)


func _process(_delta: float) -> void:
	if global_lock:
		global_position = global_lock

func move() -> void:
	global_position += velocity * speed * 0.01666666666667




func launch(launch_vel : Vector2) -> Array:
	var points = []
	position = Vector2.ZERO
	
	velocity = launch_vel
	speed = our_moon.speed
	planets_in_range = masses.get_children()
	

	for i in range(0,loops,1):

		for planet in planets_in_range:
			if planet is GravitationalMass:
				velocity += planet.get_force_to_body(self) * 0.01666666666667
		move()
		if i%3 == 0:
			points.append(position)
			
	global_lock = global_position
	return points

func _reset() -> void:
	pass
