extends Control







func _on_play_pressed():
	print("Play")
	$VBoxContainer/Play/click_sound.playing = true
	$VBoxContainer/Play/animation_play_pressed.play()
	$scene_delay.start()
	
	
	get_tree().change_scene_to_file("res://scene/main.tscn")
	
func _on_quit_pressed():
	print("Quit")
	get_tree().quit()


func _on_play_mouse_entered():
	$VBoxContainer/Play/hover_sound_play.play()
	

func _on_tree_entered():
	$menu_main_song.play()


func _on_scene_delay_timeout():
	get_tree().change_scene_to_file("res://scene/main.tscn")


func _on_tree_entered():
	$menu_main_song.play()
