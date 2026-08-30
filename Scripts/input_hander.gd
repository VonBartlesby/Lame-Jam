extends Node


@export var camera : Cam

@onready var visual: Node2D = $"../visual"
@onready var moon: Ball = $".."
@onready var line_2d: Line2D = $"../Line2D"
@onready var charge: Line2D = $"../charge"

@onready var path_finder: Node2D = $"../Path Finder"

@onready var charge_noise: AudioStreamPlayer = $AudioStreamPlayer



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
	var pitch = remap(moon_launch_velocity.length(), 0, 500, 0.1,3)
	var vol = remap(moon_launch_velocity.length(), 0, 500, 0.2,0.5) * (1 if mouseDown else 0)
	charge_noise.pitch_scale = pitch
	charge_noise.volume_linear = vol
	pass

func _unhandled_input(event):
	if not moon.shootable:
		return
	if event is InputEventMouse:
		event.position = camera.get_global_mouse_position()
		moon_launch_velocity = mouseCurrentPosition.normalized() * magnituge
		
	if event is InputEventMouseButton:
		
		
		if event.pressed && event.button_index == MOUSE_BUTTON_LEFT:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			mouseDown = true
			mouseInitialPostision = Vector2(0,0)
			mouseCurrentPosition = mouseInitialPostision
			
			
		elif mouseDown && event.button_index == MOUSE_BUTTON_LEFT:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			moon.shootable = false
			moon.started = true
			moon.charge = 0
			moon.add_velocity(moon_launch_velocity,false)

			SignalHandler.launched.emit()
			
			mouseDown = false
			visual.wobble_strength = 0
			line_2d.clear_points()
			charge.visible = false
	elif event is InputEventMouseMotion:
		mouseCurrentPosition -= (event.screen_relative * 0.8)
		
		charge.set_point_position(1,-mouseCurrentPosition )
		if mouseDown:
			line_2d.clear_points()
			charge.visible = false
			var points = path_finder.launch(moon_launch_velocity)
			magnituge = minf(500, abs(mouseCurrentPosition).length())
			visual.wobble_strength = magnituge/WOBBLE_RATIO
			charge.visible = true
			#line_2d.set_point_position(1,(moon.position-mouseCurrentPosition).normalized() * magnituge * LINE_LENGTH)
			for point in points:
				line_2d.add_point(point)
	


func _on_our_moon_impacted() -> void:
	mouseDown = false
	moon_launch_velocity = Vector2.ZERO
	line_2d.clear_points()
	visual.wobble_strength = 0
