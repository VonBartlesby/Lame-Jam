extends Area2D
class_name Ball

@export var velocity : Vector2
@export var speed : float = 1.0
@export var decleration : float = 1.0

var shootable : bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if velocity.length() > 0.01:
		move(delta)

func move(delta : float) -> void:
	position += velocity * delta * speed
	velocity = lerp(velocity,Vector2.ZERO,delta*decleration)

func add_velocity(vel:Vector2) -> void:
	velocity+=vel


func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer == 2:
		call_deferred("impact")

func impact() -> void:
	velocity*=0
	process_mode = Node.PROCESS_MODE_DISABLED
