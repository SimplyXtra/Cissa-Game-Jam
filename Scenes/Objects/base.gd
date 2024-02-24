extends Area2D
var is_player_in_base:bool = true
var player:PackedScene = preload("res://Scenes/Player/pilot.tscn")
signal damage(dmg)

func _process(delta):
	if Input.is_action_just_pressed("interact"):
		is_player_in_base = not is_player_in_base
		if is_player_in_base:
			player_enter_base()
		else:
			player_exit_base()

func player_enter_base():
	$UI.visible = true
	$Sprite2D.frame = 1

func player_exit_base():
	$UI.visible = false
	$Sprite2D.frame = 0

func _on_body_entered(body):
	damage.emit(999)
