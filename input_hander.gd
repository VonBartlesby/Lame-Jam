extends Node

@export var camera : Cam

@onready var visual: Node2D = $"../visual"
@onready var moon: Ball = $".."


var mouseDown : bool = false
var mouseInitialPostision : Vector2
var mouseToMoonDirection : Vector2
var magnituge : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if mouseDown:
		magnituge = minf(500, abs(mouseInitialPostision-get_viewport().get_mouse_position()).length())
		visual.wobble_strength = magnituge/50

func _input(event):
	if not moon.shootable:
		return
	
	if event is InputEventMouseButton:
		event.position = camera.get_global_mouse_position()
		
		if event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
			mouseDown = true
			mouseInitialPostision = event.position
			
		elif mouseDown && event.button_index == MOUSE_BUTTON_LEFT:
			moon.add_velocity((moon.position-event.position).normalized() * magnituge)
			moon.shootable = false
			mouseDown = false
			visual.wobble_strength = 0
			
	
		
