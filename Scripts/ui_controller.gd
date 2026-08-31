extends CanvasLayer
class_name UiController
@onready var reset_button: Button = $ResetButton
@onready var charge: Label = $Charge
@onready var middle_text: Label = $"Middle Text"
@onready var next_level: Button = $"Next Level"

const CHARGE_TEXT = "%d%%"

var wobble : bool = false
var wobble_strength : float = 0
var wobble_base : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_button.connect("button_up",_reset_button_clicked)
	next_level.connect("button_up",_next_button_clicked)
	SignalHandler.win.connect(_on_win)
	SignalHandler.impacted.connect(_on_crash)
	SignalHandler.level_loaded.connect(_on_level_load)
	SignalHandler.spaghettified.connect(_on_spag)
	SignalHandler.drift_off.connect(_on_drift_off)
	SignalHandler.level_loaded.connect(_on_level_loaded)
	SignalHandler.launched.connect(_on_launch)
	wobble_base = charge.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if wobble:
		var wobble_offset = Vector2(randf_range(-wobble_strength,wobble_strength),randf_range(-wobble_strength,wobble_strength))
		charge.position = wobble_base + wobble_offset * 3

func set_charge_text(charge_value:float):
	charge.text = CHARGE_TEXT % [charge_value]
	wobble_strength = charge_value * 0.01
	if charge_value == 100:
		charge.add_theme_color_override("font_color",Color.GREEN)
	else:
		charge.add_theme_color_override("font_color",Color.RED)

func _reset_button_clicked() -> void:
	SignalHandler.reset.emit()
	GameControllerAutoLoad.death_counter += 1
	middle_text.text = ""
	next_level.visible = false
	wobble = false

func _on_level_loaded():
	wobble = false

func _on_launch():
	wobble = true

func _next_button_clicked():
	SignalHandler.next_level.emit()

func _on_win(tries : int):
	var word = "resets"
	if tries == 1:
		word = "reset"
	middle_text.text = "You completed the level with %d %s" % [tries,word]
	next_level.visible = true

func _on_level_load():
	middle_text.text =""
	next_level.visible = false
	
func _on_crash():
	middle_text.text = "You crashed"

func _on_spag():
	middle_text.text = "You got sucked into a black hole"

func _on_drift_off():
	middle_text.text = "You drifted off into the vast emptiness"
