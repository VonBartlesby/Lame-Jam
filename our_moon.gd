extends Area2D
class_name Ball

@export var velocity : Vector2
@export var speed : float = 1.0
@onready var start_point: Marker2D = $"../Start Point"
@onready var reset_button: Button = $"../Ui Controller/ResetButton"


var shootable : bool = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	reset_button.connect("button_up",_reset)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if velocity.length() > 0.01:
		move(delta)

func move(delta : float) -> void:
	position += velocity * delta * speed

func add_velocity(vel:Vector2) -> void:
	velocity+=vel


func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer == 2:
		call_deferred("impact")

func impact() -> void:
	velocity*=0
	process_mode = Node.PROCESS_MODE_DISABLED

func _reset() -> void:
	velocity = Vector2.ZERO
	global_position = start_point.global_position
	shootable = true
