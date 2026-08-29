extends Node

@export var camera : Cam

@onready var visual: Node2D = $"../visual"
@onready var moon: Ball = $".."
@onready var line_2d: Line2D = $"../Line2D"
@onready var path_finder: Node2D = $"../Path Finder"


var mouseDown : bool = false
var mouseInitialPostision : Vector2
var mouseCurrentPosition : Vector2
var mouseToMoonDirection : Vector2
var magnituge : float
var moon_launch_velocity : Vector2

const LINE_LENGTH : float = 10
const WOBBLE_RATIO : float = 50

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	line_2d.add_point(Vector2.ZERO)
	line_2d.add_point(Vector2.ZERO)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _unhandled_input(event):
	if not moon.shootable:
		return
	event.position = camera.get_global_mouse_position()
	moon_launch_velocity = (moon.position-event.position).normalized() * magnituge
	if event is InputEventMouseButton:
		
		
		if event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
			mouseDown = true
			mouseInitialPostision = event.position
			mouseCurrentPosition = mouseInitialPostision
			
		elif mouseDown && event.button_index == MOUSE_BUTTON_LEFT:
			moon.add_velocity(moon_launch_velocity)
			moon.shootable = false
			mouseDown = false
			visual.wobble_strength = 0
			line_2d.clear_points()
	elif event is InputEventMouseMotion:
		mouseCurrentPosition = event.position
		if mouseDown:
			line_2d.clear_points()
			var points = path_finder.launch(moon_launch_velocity)
			magnituge = minf(500, abs(mouseInitialPostision-mouseCurrentPosition).length())
			visual.wobble_strength = magnituge/WOBBLE_RATIO
			#line_2d.set_point_position(1,(moon.position-mouseCurrentPosition).normalized() * magnituge * LINE_LENGTH)
			for point in points:
				line_2d.add_point(point)
	
