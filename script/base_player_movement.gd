extends CharacterBody2D
class_name BasePlayerMovement

const SPEED: float         = 300.0
const JUMP_VELOCITY: float = -400.0
# This is set by the game manager.
var isActive: bool = true


func set_is_active(active: bool) -> void:
	isActive = active
	if not active:
		velocity.x = 0  # TODO Fix this bug. currently we continue moving right if we deactivate the player while moving right.


func _physics_process(delta: float) -> void:
	if isActive:
		handle_input(delta)

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()


func handle_input(delta: float) -> void:
	if not isActive:
		return

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
