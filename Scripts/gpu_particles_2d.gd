extends GPUParticles2D

@onready var our_moon: Ball = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if our_moon.velocity.length() > 0.1:
		var matt = process_material as ParticleProcessMaterial
		emitting = true
		matt.direction = Vector3(our_moon.velocity.x,our_moon.velocity.y,0) * -1
	else:
		emitting = false
