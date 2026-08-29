extends Area2D
class_name Satellite

@export_range(10,300) var orbit_offset : int = 150
@export_range(-1,1) var orbit_speed : float = 0.1

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var reset_button: Button = $"../../../Ui Controller/ResetButton"
@onready var destroy_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D


var planet : GravitationalMass
var orbit_center : Vector2
var orbit_distance : float
var time : float
var dead : float = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_button.connect("button_up",reset)
	planet = get_parent()
	orbit_center = planet.position
	print(orbit_offset)
	orbit_distance = planet.size * orbit_offset
	GameControllerAutoLoad.satellites.append(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time += delta * orbit_speed
	if abs(time) > 2:
		time = 0
	var vec = Vector2.from_angle(PI * time) * orbit_distance + planet.global_position
	rotation = PI * time
	global_position = vec



func fucking_die() -> void:
	sprite_2d.visible = false
	process_mode = Node.PROCESS_MODE_DISABLED
	dead = true
	destroy_sound.play()
	GameControllerAutoLoad.check_win()

func reset() -> void:
	sprite_2d.visible = true
	process_mode =Node.PROCESS_MODE_ALWAYS
	time = 0
	dead = false

func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer == 1:
		call_deferred("fucking_die")
