extends TextureRect
@export var parallax := 0.1
@export var cam :Camera2D

func _ready() -> void:
	var resize : Callable = (func():
		var vp=get_viewport_rect()
		texture.width=vp.size.x
		texture.height=vp.size.y)
	resize.call_deferred()
	get_viewport().size_changed.connect(resize,CONNECT_DEFERRED)
func _process(_delta: float) -> void:
	var cam_offset = cam.position * parallax
	texture.noise.offset=Vector3(cam_offset.x,cam_offset.y,0.)
	#FastNoiseLite
