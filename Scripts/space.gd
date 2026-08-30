extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func clear_level():
	#negetive indexing gets the latest child in the tree
	get_child(-1).queue_free()
	
