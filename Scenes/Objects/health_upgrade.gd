extends "res://Scenes/Objects/upgrade_base.gd"

func upgrade():
	match upgrade_level:
		0:
			Global.base_max_health = 300
			Global.base_health = Global.base_max_health
		1:
			Global.base_max_health = 400
			Global.base_health = Global.base_max_health
		2:
			Global.base_max_health = 500
			Global.base_health = Global.base_max_health
