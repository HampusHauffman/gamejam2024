extends Area2D

@export var speed: int = 400


# Called when the node enters the scene tree for the first time.
func _ready():
    print("HELLO12")
    pass


func _input(event: InputEvent) -> void:
    var velocity := Vector2()
    if event.is_action_pressed("ui_right"):
        velocity.x += 1
    if event.is_action_pressed("ui_left"):
        velocity.x -= 1
    pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
    pass

