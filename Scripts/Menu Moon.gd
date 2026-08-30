extends Node2D



@onready var button: Button = $"../CanvasLayer/Button"
@onready var texture_rect: ColorRect = $"../CanvasLayer/TextureRect"
@onready var label: Label = $"../CanvasLayer/Label"
@onready var gpu_particles_2d: GPUParticles2D = $GPUParticles2D

@onready var visual: Node2D = $visual

var move = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalHandler.fade_fin.connect(_on_fade_fin)
	button.connect("button_up",_on_begin_button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if move:
		position = position.lerp(get_viewport_rect().size * Vector2(1,-1),delta)

func _on_begin_button():
	move = true
	SignalHandler.next_level.emit()

func _on_fade_fin():
	button.visible = false
	visual.visible = false
	label.visible = false
	gpu_particles_2d.emitting = false


func _on_h_slider_drag_ended(value_changed: float) -> void:
	AudioServer.set_bus_volume_linear(1,value_changed)


func _on_sfx_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(2,value)


func _on_master_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(0,value)
