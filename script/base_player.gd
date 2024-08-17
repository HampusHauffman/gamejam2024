extends RigidBody2D
class_name BasePlayer

const JUMP_VELOCITY: float = -100.0
const PUSH_STRENGTH: float = 2000.0  # Adjust this value as needed
const MAX_SPEED: float     = 200.0  # Maximum speed for the player
# This is set by the game manager.
var isActive: bool = false

@export var zoom: float = 1.0

@onready var area_2d = $Area2D
# Reference to the CollisionShape2D node
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func _ready() -> void:
	pass


func set_is_active(active: bool) -> void:
	isActive = active


func _physics_process(delta: float) -> void:
	if isActive:
		handle_input(delta)


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	state.linear_velocity.x = clamp(state.linear_velocity.x, -MAX_SPEED, MAX_SPEED)


func handle_input(delta: float) -> void:
	if not isActive:
		return

	if not is_on_floor() and  isActive:
		var physics_material: PhysicsMaterial = PhysicsMaterial.new()
		physics_material.set_friction(0)
		set_physics_material_override(physics_material)
	else:
		var physics_material: PhysicsMaterial = PhysicsMaterial.new()
		physics_material.set_friction(1)
		set_physics_material_override(physics_material)

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		apply_central_impulse(Vector2(0, JUMP_VELOCITY))

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction != 0:
		apply_central_impulse(Vector2(direction * PUSH_STRENGTH * delta, 0))


func is_on_floor() -> bool:
	for a in area_2d.get_overlapping_bodies():
		if a != self:
			return true
	return false
