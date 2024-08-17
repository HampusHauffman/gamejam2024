extends CharacterBody2D
class_name BasePlayer

const SPEED: float         = 300.0
const JUMP_VELOCITY: float = -400.0
const PUSH_STRENGTH: float = 200.0  # Adjust this value as needed
# This is set by the game manager.
var isActive: bool = false

@export var zoom: float = 1.0

# Reference to the CollisionShape2D node
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


func set_is_active(active: bool) -> void:
	isActive = active
	if not active:
		velocity.x = 0  # TODO Fix this bug. currently we continue moving right if we deactivate the player while moving right.
	else:
		# Re-enable physics and d setach from any parent
		set_physics_process(true)
		if get_parent() is BasePlayer:
			reparent(get_tree().get_root())


func _physics_process(delta: float) -> void:
	if isActive:
		handle_input(delta)

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()

	# Check for collisions with other BasePlayer instances below
	for i in get_slide_collision_count():
		var collision: KinematicCollision2D = get_slide_collision(i)
		if collision.get_collider() is BasePlayer:
			var normal: Vector2 = collision.get_normal()
			if normal.y == -1 and not isActive:
				# Disable physics and make the current player a child of the colliding BasePlayer
				set_physics_process(false)
				var other_player: BasePlayer = collision.get_collider() as BasePlayer
				reparent(other_player)
				# Add a small offset to avoid getting stuck in the ground
				position.y -= 0.1


func handle_input(delta: float) -> void:
	if not isActive:
		return

	# Check if there is a child of type BasePlayer
	var has_child_base_player := false
	for child in get_children():
		if child is BasePlayer:
			has_child_base_player = true
			break

	# Handle jump.
	if Input.is_action_pressed("jump") and is_on_floor() and not has_child_base_player:
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
