extends CharacterBody2D
class_name BasePlayer

const SPEED: float         = 300.0
const JUMP_VELOCITY: float = -400.0
# This is set by the game manager.
var isActive: bool     = false
var is_on_ground: bool = false


@export var zoom: float = 1.0


func set_is_active(active: bool) -> void:
	isActive = active
	#if not active:
	#	velocity.x = 0  # TODO Fix this bug. currently we continue moving right if we deactivate the player while moving right.


func _physics_process(delta: float) -> void:
	if isActive:
		handle_input(delta)

	# Add the gravity.
	if not is_on_ground:
		velocity += get_gravity() * delta
		
	var horizontal_velocity: Vector2    = Vector2(velocity.x, 0)
	var collision: KinematicCollision2D = move_and_collide(horizontal_velocity * delta * zoom/2)
	if collision:
		var slide_factor: int = 1  # Adjust this value to control sliding
		horizontal_velocity = horizontal_velocity.slide(collision.get_normal()) * slide_factor
		velocity.x = horizontal_velocity.x

	# Handle vertical movement
	collision = move_and_collide(Vector2(0, velocity.y * delta * zoom/2))
	if collision:
		if collision.get_normal().dot(Vector2.UP) > 0.7:  # Adjust this value as needed
			is_on_ground = true
		else:
			is_on_ground = false
			velocity.y = 0
	else:
		is_on_ground = false

func handle_input(delta: float) -> void:
	if not isActive:
		return

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_ground:
		velocity.y = JUMP_VELOCITY
		is_on_ground = false

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
