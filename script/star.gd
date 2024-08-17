extends Area2D

@export var players: BasePlayer


func _on_body_entered(body):
	if players == body:
		queue_free()
