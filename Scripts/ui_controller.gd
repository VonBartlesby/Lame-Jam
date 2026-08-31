extends CanvasLayer
class_name UiController
@onready var reset_button: Button = $ResetButton
@onready var charge: Label = $Charge
@onready var middle_text: Label = $"Middle Text"
@onready var next_level: Button = $"Next Level"

const CRASH_MESSAGES : Array[String] = [
	"On to attempt number %d",
	"You Crashed",
	"Boom boom",
	"Goodbye dinosaurs",
	"Ouch!",
	"Not like that...",
	"Everyone is dead"
]

const WIN_MESSAGES : Array[String] = [
	"You completed the level with %d %s",
	"%d%s times the charm",
	"%d %s were harmed in the completion of this level",
	"That one egg was %d eggs?",
]

const DRIFT_MESSAGES : Array[String] = [
	"You drifted off into the vast emptiness",
	"Goodbye forever",
	"Ummm that's the wrong way",
	"Where are you going?",
	"Off to the store for some milk",
	"Won't be back in time for supper"
]

const SPAG_MESSAGES : Array[String] = [
	"You fell into a black hole",
	"Moon spaghetti",
	"Vorp",
	"Not getting out of that one",
	"*interstellar music*",
]

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
	var message = randi_range(0,WIN_MESSAGES.size()-1)
	var word = "FUCK!"
	
	if message == 0:
		word = "resets"
		if tries == 1:
			word = "reset"
		middle_text.text = WIN_MESSAGES[message] % [tries,word]
	elif message == 1:
		word = "th"
		if tries % 10 as int == 2:
			word ="nd"
		elif tries % 10 as int == 3:
			word = "rd"
		elif tries % 10 as int == 1:
			word = "st"
		middle_text.text = WIN_MESSAGES[message] % [tries+1,word]
	elif message == 2:
		word = "moons"
		if tries == 1:
			word = "moon"
		middle_text.text = WIN_MESSAGES[message] % [tries,word]
	elif message == 3:
		middle_text.text = WIN_MESSAGES[message] % [tries+1]
	
	next_level.visible = true

func _on_level_load():
	middle_text.text =""
	next_level.visible = false
	
func _on_crash():
	var message = randi_range(0,WIN_MESSAGES.size()-1)
	if message == 0:
		middle_text.text = CRASH_MESSAGES[message] % [GameControllerAutoLoad.death_counter+1]
	else:
		middle_text.text = CRASH_MESSAGES[message]

func _on_spag():
	var message = randi_range(0,SPAG_MESSAGES.size()-1)
	middle_text.text = SPAG_MESSAGES[message]

func _on_drift_off():
	var message = randi_range(0,DRIFT_MESSAGES.size()-1)
	middle_text.text = DRIFT_MESSAGES[message]
