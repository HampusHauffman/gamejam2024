extends Node2D
class_name BasePlayer

const SPEED: float         = 300.0
const JUMP_VELOCITY: float = -400.0
@export var zoom: float = 1.0

@onready var base_player_movement: BasePlayerMovement = $BasePlayerMovement
@onready var rigid_body_2d: RigidBody2D = $RigidBody2D


func set_is_active(active: bool) -> void:
	# Here we switch to base_player_movement
	if(active):
		base_player_movement.position = rigid_body_2d.position

		base_player_movement.process_mode = Node.PROCESS_MODE_INHERIT

		rigid_body_2d.process_mode = Node.PROCESS_MODE_DISABLED

	else:
		rigid_body_2d.position = base_player_movement.position

		base_player_movement.process_mode = Node.PROCESS_MODE_DISABLED

		rigid_body_2d.process_mode = Node.PROCESS_MODE_INHERIT
	base_player_movement.set_is_active(active)
