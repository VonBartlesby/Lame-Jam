extends Area2D
class_name Satellite

@export_range(10,300) var orbit_offset : int = 150
@export_range(-1,1) var orbit_speed : float = 0.1
@export_range(0,360) var start_rotation : float = 0.0
@export var stationary : bool = false

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var destroy_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var explosion: CPUParticles2D = $CPUParticles2D
@onready var light: PointLight2D = $PointLight2D



var planet : GravitationalMass
var orbit_center : Vector2
var orbit_distance : float
var time : float
var dead : float = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHandler.connect("reset",reset)
	if not stationary:
		planet = get_parent()
		orbit_center = planet.position
		orbit_distance = planet.size * orbit_offset
		GameControllerAutoLoad.satellites.append(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not stationary:
		time += delta * orbit_speed
		if abs(time) > 2:
			time = 0
		var vec = Vector2.from_angle((PI * time) + deg_to_rad(start_rotation)) * orbit_distance + planet.global_position
		rotation = PI * time
		global_position = vec



func fucking_die() -> void:
	sprite_2d.visible = false
	set_process(false)
	dead = true
	destroy_sound.play()
	explosion.emitting = true
	light.energy=1.
	var t := get_tree().create_tween()
	t.set_process_mode(Tween.TWEEN_PROCESS_PHYSICS)
	t.bind_node(self)
	t.tween_property(light,"energy",0.,2.)
	t.set_ease(Tween.EASE_IN)
	t.play()
	GameControllerAutoLoad.check_win()

func reset() -> void:
	sprite_2d.visible = true
	set_process(false)
	time = 0
	dead = false

func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer == 1:
		call_deferred("fucking_die")
