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
	if not shootable:
		velocity+=vel


func _on_area_entered(area: Area2D) -> void:
	print("que?")
	if area.collision_layer == 2:
		print("so this is running?")
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(global_position, area.global_position,2)
		query.collide_with_areas = true
		query.hit_from_inside = true
		var result = space_state.intersect_ray(query)
		
		#un comment to draw the rays on impact
		#var line = Line2D.new()
		#line.add_point(Vector2.ZERO)
		#line.add_point(to_local(area.global_position))
		#line.z_index = 1
		#add_child(line)
		
		if result:
			var impact_angle = velocity.angle_to(result["normal"])
			print(impact_angle)
			if abs(impact_angle) >= 2 or abs(impact_angle) <= 1:
				call_deferred("impact")
			else:
				var shallow_reflected_about_vel : Vector2= velocity - 1.8 * (velocity.dot(result["normal"])) * result["normal"]
				velocity = shallow_reflected_about_vel * 0.9

func impact() -> void:
	velocity*=0
	process_mode = Node.PROCESS_MODE_DISABLED

func _reset() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	velocity = Vector2.ZERO
	global_position = start_point.global_position
	shootable = true
