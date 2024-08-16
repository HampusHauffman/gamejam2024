extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_out"):
		PlayerNumber.current_player += 1
		print(PlayerNumber.current_player)
		print("zoom out!!!")
	if event.is_action_pressed("zoom_in"):
		PlayerNumber.current_player -= 1
		print("zoom in!!!")
