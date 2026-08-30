@icon("res://Icons/Weezer.png")
class_name Ball
extends Area2D


@export var velocity : Vector2
@export var speed : float = 1.0
@export var max_charge : float = 100
@export var charge_speed : float = 1.0
@export var drift_off_timeout : float = 5
@onready var visual: Node2D = $visual


@onready var ui_controller: UiController = $"../Ui Controller"
@onready var trail: GPUParticles2D = $GPUParticles2D

@onready var rings: CPUParticles2D = $Explosion/Rings
@onready var particles: CPUParticles2D = $Explosion/Particles
@onready var bang: CPUParticles2D = $Explosion/Bang

var spin :float=0.

var started : bool = false
var shootable : bool = false
var drift_off_timer : float = 0
var previous_velocity : Vector2 = Vector2.ZERO
var charge : float :
	set(c):
		charge = minf(c,max_charge)
		set_charge_text()
		if charge == max_charge:
			shootable = true

var charge_percentage : float
var start_point : Marker2D
const CHARGE_SPEED_BASE = 0.01

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("area_entered",_on_area_entered)
	SignalHandler.reset.connect(_reset)
	SignalHandler.level_loaded.connect(_on_level_load)
	SignalHandler.drift_off.connect(_on_drift_off)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if velocity.length() > 0.01:
		move(delta)
		if velocity == previous_velocity:
			drift_off_timer += delta
		else:
			drift_off_timer = 0
		if drift_off_timer > drift_off_timeout:
			SignalHandler.drift_off.emit()
	previous_velocity = velocity

func move(delta : float) -> void:
	position += velocity * delta * speed
		

func add_velocity(vel:Vector2,recharge : bool = true) -> void:
	var _v=velocity
	velocity+=vel
	spin+=_v.angle_to(velocity)*2.5
	if recharge:
		charge += vel.length() * CHARGE_SPEED_BASE * charge_speed


func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer == 2:
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(global_position, area.global_position,2)
		query.collide_with_areas = true
		query.hit_from_inside = true
		var result = space_state.intersect_ray(query)
		
		if result:
			var impact_angle = velocity.angle_to(result["normal"])
			if abs(impact_angle) >= 2 or abs(impact_angle) <= 1.64:
				
				call_deferred("impact")
				
			else:
				var shallow_reflected_about_vel : Vector2= velocity - 2 * (velocity.dot(result["normal"])) * result["normal"]
				velocity = shallow_reflected_about_vel * 0.95
				SignalHandler.reflected.emit()
	
	
	elif area.collision_layer == 4:
		call_deferred("spaghettification")
	
	
	elif area.collision_layer == 16:
		velocity *= 0.95
		#to fix this
		velocity = velocity.from_angle(randf_range(-0.1,0.1)) * velocity.length()

func impact() -> void:
	SignalHandler.impacted.emit()
	velocity*=0
	started = false
	rings.emitting = true
	particles.emitting = true
	bang.emitting = true
	visual.visible = false
	process_mode = Node.PROCESS_MODE_DISABLED

func spaghettification() -> void:
	SignalHandler.spaghettified.emit()
	velocity*=0
	started = false
	#rings.emitting = true
	#particles.emitting = true
	#bang.emitting = true
	process_mode = Node.PROCESS_MODE_DISABLED

func _reset() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	velocity = Vector2.ZERO
	if not start_point == null:
		global_position = start_point.global_position
	shootable = true
	started = false
	charge = 100
	visual.visible = true
	trail.restart()
	

func set_charge_text():
	charge_percentage = charge/max_charge*100
	ui_controller.set_charge_text(charge_percentage)

func _on_level_load() -> void:
	for child in $"..".get_child(-1).get_children():
		if child is Marker2D:
			start_point = child
	_reset()

func _on_drift_off() -> void:
	shootable = false
