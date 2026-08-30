extends Node2D

@onready var woosh_sound:AudioStreamPlayer2D = $woosh
@onready var woosh_high_sound:AudioStreamPlayer2D = $"woosh high"
@onready var woosh_rumble_sound:AudioStreamPlayer2D = $"woosh rumble"
@onready var impact_sound:AudioStreamPlayer2D = $impact
@onready var reflect_sound:AudioStreamPlayer2D = $reflect
@onready var launch_sound:AudioStreamPlayer2D = $launch
@onready var planet:Ball = $".."
@onready var spaghettified_sound: AudioStreamPlayer2D = $spaghettified

var velocity_sound_volume = 0.2

var pitch_scale_target : float
var pitch_scale_2_target : float
var volume_scale_target : float
var volume_scale_target_rumble : float


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	woosh_sound.volume_linear = 0
	woosh_high_sound.volume_linear = 0
	woosh_rumble_sound.volume_linear = 0
	#connect signals
	SignalHandler.launched.connect(_on_input_hander_launched)
	SignalHandler.impacted.connect(_on_our_moon_impacted)
	SignalHandler.reflected.connect(_on_our_moon_reflected)
	SignalHandler.spaghettified.connect(_on_our_moon_spag)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if planet.velocity.length() > 0.5:
		pitch_scale_target = remap(planet.velocity.length(), 0, 400, 0.2, 2)
		pitch_scale_2_target = remap(planet.velocity.length_squared(), 0, 300000, 0.1, 6)
		volume_scale_target = remap(planet.velocity.length(), 100, 300, 0.2, 1) * velocity_sound_volume
		volume_scale_target_rumble = remap(planet.velocity.length(), 200, 700, 0.1, 1) * velocity_sound_volume
		woosh_sound.pitch_scale = lerp(woosh_sound.pitch_scale,pitch_scale_target,delta)
		woosh_high_sound.pitch_scale = lerp(woosh_high_sound.pitch_scale,pitch_scale_2_target,delta)
		woosh_sound.volume_linear = maxf(lerp(woosh_sound.volume_linear,volume_scale_target,delta),0)
		woosh_high_sound.volume_linear = maxf(lerp(woosh_sound.volume_linear,volume_scale_target,delta) * 0.3,0)
		woosh_rumble_sound.volume_linear = maxf(lerp(woosh_rumble_sound.volume_linear,volume_scale_target_rumble,delta),0)
	else:
		woosh_sound.volume_linear = 0
		woosh_high_sound.volume_linear = 0
		woosh_rumble_sound.volume_linear = 0


func _on_our_moon_impacted() -> void:
	impact_sound.play()
	pass # Replace with function body.


func _on_our_moon_reflected() -> void:
	reflect_sound.play()
	pass # Replace with function body.


func _on_input_hander_launched() -> void:
	launch_sound.play()
	pass # Replace with function body.

func _on_our_moon_spag() -> void:
	spaghettified_sound.play()
