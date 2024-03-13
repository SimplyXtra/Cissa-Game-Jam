extends CanvasLayer


func _on_start_game_pressed():
	Global.reset()
	get_tree().change_scene_to_file("res://Scenes/Level/Level.tscn")


func _on_quit_game_pressed():
	get_tree().quit()
