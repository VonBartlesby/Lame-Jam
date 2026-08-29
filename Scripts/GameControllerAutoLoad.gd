extends Node

var satellites : Array[Satellite]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func check_win() -> void:
	for satellite in satellites:
		if not satellite.dead:
			return
	print("winner")
