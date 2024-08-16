extends Node
class_name GameManager

# The index of the active player.
@export var active_player_index: int = 0
# The list of players in the scene. These players are only referd to so the camera can switch between them.
@export var players: Array[BasePlayer] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    # Activate the first player.
    players[active_player_index].set_is_active(true)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func _input(event: InputEvent) -> void:
    # Change the active player.
    if event.is_action_pressed("zoom_out"):
        change_active_player(1)
    if event.is_action_pressed("zoom_in"):
        change_active_player(-1)


func change_active_player(direction: int) -> void:
    # Deactivate the current player
    players[active_player_index].set_is_active(false)
    # Update the active player index
    active_player_index += direction
    # Ensure the index is within bounds
    active_player_index = clamp(active_player_index, 0, players.size() - 1)
    # Activate the new player
    players[active_player_index].set_is_active(true)
    # Zoom the camera
    print(str("zoom: ", active_player_index))
    # Change the camera parent
    change_camera_parent(direction)


# Reparent the camera to the new active player
func change_camera_parent(direction: int) -> void:
    var camera: Camera2D = players[active_player_index-direction].get_node("Camera2D")
    if camera:
        camera.reparent(players[active_player_index])
        # TODO make this smooth
        camera.position = Vector2(0, 0)
