extends "res://Scenes/Objects/upgrade_base.gd"

func upgrade():
	match upgrade_level:
		0:
			Global.bullet_penetration = 2
		1:
			Global.bullet_penetration = 3
		2:
			Global.bullet_penetration = 4
