extends Node

@export var music_player: AudioStreamPlayer

var stream:AudioStreamPlaybackInteractive
var music_stream:AudioStreamSynchronized
#var bass_vol:float = 1.0
#var drums_vol:float = 1.0
#var lead_vol:float = 1.0
#var music_vol:float = 1.0
var riser_vol:float = -60.0
#var start_vol:float = 1.0
#
#var bass_vol_target:float = 1.0
#var drums_vol_target:float = 1.0
#var lead_vol_target:float = 1.0
#var music_vol_target:float = 1.0
var riser_vol_target:float = -60.0
#var start_vol_target:float = 1.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	stream = music_player.get_stream_playback()
	music_stream = music_player.stream.get("clip_0/stream")
	SignalHandler.next_level.connect(fade_to_start)
	SignalHandler.win.connect(fade_to_music)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	#bass_vol = lerp(bass_vol, bass_vol_target, delta * )
	
	#stream.set_sync_stream_volume(0,bass_vol)
	#stream.set_sync_stream_volume(1,drums_vol)
	#stream.set_sync_stream_volume(2,lead_vol)
	#stream.set_sync_stream_volume(3,music_vol)
	#stream.set_sync_stream_volume(4,riser_vol)
	#stream.set_sync_stream_volume(5,start_vol)
	riser_vol = lerp(riser_vol, riser_vol_target, delta * 10)
	music_stream.set_sync_stream_volume(4,riser_vol)
	
	pass
	
func fade_to_start():
	riser_vol_target = 0.0 # fade in riser
	stream.switch_to_clip_by_name("Start")
	await get_tree().create_timer(4.0).timeout
	riser_vol_target = -60.0 # fade out riser

func fade_to_music():
	stream.switch_to_clip_by_name("Music")
	
