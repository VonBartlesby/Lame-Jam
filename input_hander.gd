extends Node


@onready var moon: Sprite2D = $".."


var mouseDown : bool = false
var mouseInitialPostision : Vector2
var mouseToMoonDirection : Vector2
var magnituge : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		if event.pressed:
			mouseDown = true
			mouseInitialPostision = event.position
			print("Mouse at: ", mouseInitialPostision)
			print("Moon at: ", moon.position)
			print("dir: ", (moon.position-event.position).normalized())
			
		elif mouseDown:
			magnituge = abs(mouseInitialPostision-event.position).length()
			moon.add_velocity((moon.position-event.position).normalized() * magnituge)
