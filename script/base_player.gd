extends RigidBody2D
class_name BasePlayer

const JUMP_VELOCITY: float = -100.0
const PUSH_STRENGTH: float = 2000.0  # Adjust this value as needed
const MAX_SPEED: float     = 200.0  # Maximum speed for the player
# This is set by the game manager.
var isActive: bool = false

@export var zoom: float = 1.0

# Reference to the CollisionShape2D node
@onready var collision_shape: CollisionShape2D = $CollisionShape2D
# Raycast to check for floor collision

func set_is_active(active: bool) -> void:
	isActive = active

func _physics_process(delta: float) -> void:
	if isActive:
		handle_input(delta)

	print(linear_velocity)

func handle_input(delta: float) -> void:
	if not isActive:
		return

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		apply_central_impulse(Vector2(0, JUMP_VELOCITY))

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("left", "right")
	if direction != 0:
		apply_central_impulse(Vector2(direction * PUSH_STRENGTH * delta, 0))
		linear_velocity.clamp(Vector2(-MAX_SPEED, -MAX_SPEED), Vector2(MAX_SPEED, MAX_SPEED))

func is_on_floor() -> bool:
	for a in get_colliding_bodies()

