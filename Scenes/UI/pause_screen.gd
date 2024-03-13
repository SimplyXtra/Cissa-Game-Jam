extends CanvasLayer

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		get_tree().paused = not get_tree().paused
		if get_tree().paused: visible = true
		else: visible = false

func _on_resume_game_pressed():
	visible = false
	get_tree().paused = false

func _on_restart_game_pressed():
	get_tree().paused = false
	Global.reset()
	get_tree().reload_current_scene()
