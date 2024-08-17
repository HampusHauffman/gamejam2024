extends Node2D
class_name BasePlayer

const SPEED: float         = 300.0
const JUMP_VELOCITY: float = -400.0
# This is set by the game manager.
var isActive: bool = false

@export var zoom: float = 1.0

@onready var base_player_movement: BasePlayerMovement = $BasePlayerMovement


func set_is_active(active: bool) -> void:
	isActive = active
	base_player_movement.set_is_active(active)
