extends RigidBody2D
class_name BasePlayer

const JUMP_FORCE: float = -100.0
const GRAVITY: Vector2  = Vector2(0, 980)  # Define gravity
const MAX_SPEED: float  = 50.0  # Define maximum speed
# This is set by the game manager.
@export var SPEED: float = 60000.0

var isActive: bool  = false
var on_ground: bool = false

@export var zoom: float = 1.0

@onready var is_on_ground_checker: CollisionShape2D = %IsOnGroundChecker


func set_is_active(active: bool) -> void:
	isActive = active
	if not active:
		linear_velocity = Vector2.ZERO  # Stop movement when deactivated


func _input(event: InputEvent) -> void:
	if isActive:
		if Input.is_action_pressed("jump") and on_ground:
			apply_central_impulse(Vector2(0, JUMP_FORCE * mass))
			on_ground = false

		# Get the input direction and handle the movement
		var direction := Input.get_axis("left", "right")
		if direction:
			apply_central_force(Vector2(direction * SPEED * mass, 0))

		# Clamp the linear velocity to the maximum speed
		linear_velocity.x = clamp(linear_velocity.x, -MAX_SPEED, MAX_SPEED)


func _on_rigid_body_2d_body_entered(body: Node) -> void:
	print("Player entered the body")
	pass # Replace with function body.
