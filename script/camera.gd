extends Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_tree_entered():
	var player: BasePlayer = get_parent()
	zoom = Vector2(1/player.zoom, 1/player.zoom)
