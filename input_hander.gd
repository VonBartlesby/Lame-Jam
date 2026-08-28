extends Node

@export var camera : Cam

@onready var visual: Node2D = $"../visual"
@onready var moon: Ball = $".."
@onready var line_2d: Line2D = $"../Line2D"


var mouseDown : bool = false
var mouseInitialPostision : Vector2
var mouseCurrentPosition : Vector2
var mouseToMoonDirection : Vector2
var magnituge : float

const LINE_LENGTH : float = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line_2d.add_point(Vector2.ZERO)
	line_2d.add_point(Vector2.ZERO)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if mouseDown:
		magnituge = minf(500, abs(mouseInitialPostision-mouseCurrentPosition).length())
		visual.wobble_strength = magnituge/50
		line_2d.set_point_position(1,(moon.position-mouseCurrentPosition).normalized() * magnituge * LINE_LENGTH)

func _input(event):
	if not moon.shootable:
		return
	
	if event is InputEventMouseButton:
		event.position = camera.get_global_mouse_position()
		
		if event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
			mouseDown = true
			mouseInitialPostision = event.position
			mouseCurrentPosition = mouseInitialPostision
			
		elif mouseDown && event.button_index == MOUSE_BUTTON_LEFT:
			moon.add_velocity((moon.position-event.position).normalized() * magnituge)
			moon.shootable = false
			mouseDown = false
			visual.wobble_strength = 0
			line_2d.set_point_position(1,Vector2.ZERO)
	elif event is InputEventMouseMotion:
		event.position = camera.get_global_mouse_position()
		mouseCurrentPosition = event.position
	
		
