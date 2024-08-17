extends Camera2D

var targetPos : Vector2 = position
var targetZoom : float = zoom.x
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = position.move_toward(targetPos, delta*40000)
	zoom = zoom.move_toward(Vector2(1/targetZoom, 1/targetZoom), delta)
	
func _zoom(z : int):
	targetZoom = z
