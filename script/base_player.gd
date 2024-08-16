extends CharacterBody2D

const SPEED: float         = 300.0
const JUMP_VELOCITY: float = -400.0
@onready var player_number: int = $PlayerNumber.player_number

@onready var game_manager: GameManager = %GameManager


func _physics_process(delta: float) -> void:
	if player_number == game_manager.current_player:
		handle_input(delta)

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	move_and_slide()


func handle_input(delta: float) -> void:
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
