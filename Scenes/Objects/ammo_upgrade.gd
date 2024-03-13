extends "res://Scenes/Objects/upgrade_base.gd"

func upgrade():
	match upgrade_level:
		0:
			Global.base_max_ammo = 15
			Global.bullet_reload_time = 0.85
		1:
			Global.base_max_ammo = 20
			Global.bullet_reload_time = 0.7
		2:
			Global.base_max_ammo = 25
			Global.bullet_reload_time = 0.5
