extends CanvasLayer
class_name UiController
@onready var reset_button: Button = $ResetButton
@onready var charge: Label = $Charge

const CHARGE_TEXT = "%d%%"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func set_charge_text(charge_value:float):
	charge.text = CHARGE_TEXT % [charge_value]
	if charge_value == 100:
		charge.add_theme_color_override("font_color",Color.GREEN)
	else:
		charge.add_theme_color_override("font_color",Color.RED)
