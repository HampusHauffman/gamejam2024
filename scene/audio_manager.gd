extends Node
 
#var IsSliding : bool = false
#var IsSlidingHeldDown : bool = false
# Called when the node enters the scene tree for the first time.
	
func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("jump"):
		$JumpSFX.play()
 # Replace with function body.

	if Input.is_action_just_pressed("zoom_out"):
		$ZoomOutSound.play()
		$MusicGame.set_pitch_scale(0.9)

	if Input.is_action_just_pressed("zoom_in"):
		$ZoomInSound.play()
		$MusicGame.set_pitch_scale(1)



	#if Input.is_action_pressed("left"):
		#IsSliding != IsSliding
	#else:
		
		
	#if IsSliding:
		#$SlideSound.playing = true
	#else:
		#$SlideSound.playing =false
 # Replace with function body.
