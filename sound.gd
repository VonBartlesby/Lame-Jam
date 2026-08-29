extends Node2D

@onready var audio_player:AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_player_2:AudioStreamPlayer2D = $AudioStreamPlayer2D2
@onready var planet:Ball = $".."

var velocity_sound_volume = 0.5

var pitch_scale_target : float
var pitch_scale_2_target : float
var volume_scale_target : float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	audio_player.volume_linear = 0
	audio_player_2.volume_linear = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if planet.velocity.length() > 0.5:
		pitch_scale_target = remap(planet.velocity.length(), 0, 400, 0.2, 2)
		pitch_scale_2_target = remap(planet.velocity.length_squared(), 0, 300000, 0.1, 6)
		volume_scale_target = remap(planet.velocity.length(), 100, 300, 0.2, 1) * velocity_sound_volume
		audio_player.pitch_scale = lerp(audio_player.pitch_scale,pitch_scale_target,delta)
		audio_player_2.pitch_scale = lerp(audio_player_2.pitch_scale,pitch_scale_2_target,delta)
		audio_player.volume_linear = maxf(lerp(audio_player.volume_linear,volume_scale_target,delta),0)
		audio_player_2.volume_linear = maxf(lerp(audio_player.volume_linear,volume_scale_target,delta) * 0.3,0)
	else:
		audio_player.volume_linear = 0
		audio_player_2.volume_linear = 0
