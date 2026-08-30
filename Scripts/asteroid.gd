extends Area2D


@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var destroy_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var explosion: CPUParticles2D = $CPUParticles2D


var rotaion_speed : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHandler.connect("reset",reset)
	rotaion_speed = randf_range(-2,2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	sprite_2d.rotate(rotaion_speed* delta)



func fucking_die() -> void:
	sprite_2d.visible = false
	process_mode = Node.PROCESS_MODE_DISABLED
	destroy_sound.play()
	explosion.emitting = true

func reset() -> void:
	sprite_2d.visible = true
	process_mode =Node.PROCESS_MODE_ALWAYS

func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer == 1:
		call_deferred("fucking_die")
