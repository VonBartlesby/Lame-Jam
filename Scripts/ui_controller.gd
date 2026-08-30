extends CanvasLayer
class_name UiController
@onready var reset_button: Button = $ResetButton
@onready var charge: Label = $Charge
@onready var middle_text: Label = $"Middle Text"
@onready var next_level: Button = $"Next Level"

const CHARGE_TEXT = "%d%%"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_button.connect("button_up",_reset_button_clicked)
	next_level.connect("button_up",_next_button_clicked)
	SignalHandler.win.connect(_on_win)
	SignalHandler.impacted.connect(_on_crash)
	SignalHandler.level_loaded.connect(_on_level_load)
	SignalHandler.spaghettified.connect(_on_spag)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_charge_text(charge_value:float):
	charge.text = CHARGE_TEXT % [charge_value]
	if charge_value == 100:
		charge.add_theme_color_override("font_color",Color.GREEN)
	else:
		charge.add_theme_color_override("font_color",Color.RED)

func _reset_button_clicked() -> void:
	SignalHandler.reset.emit()
	middle_text.text = ""
	next_level.visible = false
	
func _next_button_clicked():
	SignalHandler.next_level.emit()

func _on_win():
	middle_text.text = "Winner"
	next_level.visible = true

func _on_level_load():
	middle_text.text =""
	next_level.visible = false
	
func _on_crash():
	middle_text.text = "You crashed"

func _on_spag():
	middle_text.text = "You got sucked into a black hole"
