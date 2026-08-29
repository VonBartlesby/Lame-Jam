extends Node2D

@onready var audio_player:AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_player_2:AudioStreamPlayer2D = $AudioStreamPlayer2D2
@onready var planet:Ball = $".."

var velocity_sound_volume = 0.5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_player.pitch_scale = 0
	audio_player_2.pitch_scale = 0
	audio_player.volume_linear = 0
	audio_player_2.volume_linear = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if planet.velocity.length() > 0.01:
		var vel = remap(planet.velocity.length(), 0, 400, 0.2, 2)
		var vel2 = remap(planet.velocity.length_squared(), 0, 300000, 0.1, 6)
		var vol = remap(planet.velocity.length(), 100, 300, 0.2, 1) * velocity_sound_volume
		audio_player.pitch_scale = vel
		audio_player_2.pitch_scale = vel2
		audio_player.volume_linear = vol
		audio_player_2.volume_linear = vol * 0.3

	else:
		audio_player.pitch_scale = 0
		audio_player_2.pitch_scale = 0
		audio_player.volume_linear = 0
		audio_player_2.volume_linear = 0
