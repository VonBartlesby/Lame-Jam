extends Node2D



@onready var menu_moon: Node2D = $"Menu Moon"
@onready var button: Button = $CanvasLayer/Button
@onready var label: Label = $CanvasLayer/Label
@onready var v_box_container: VBoxContainer = $CanvasLayer/VBoxContainer
@onready var level_select: ScrollContainer = $"CanvasLayer/Level Select"



var move = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#GameControllerAutoLoad.start_fade_in.connect(_on_fade_fin)
	button.connect("button_up",_on_begin_button)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if move:
		position = position.lerp(get_viewport_rect().size * Vector2(1,-1),delta)

func _on_begin_button():
	move = true
	button.disabled = true
	SignalHandler.next_level.emit()

func on_fade_fin():
	button.visible = false
	menu_moon.visible = false
	v_box_container.visible = false
	level_select.visible = false
	label.visible = false

func _on_h_slider_drag_ended(value_changed: float) -> void:
	AudioServer.set_bus_volume_linear(1,value_changed)


func _on_sfx_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(2,value)


func _on_master_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_linear(0,value)
