extends "res://Scenes/Objects/upgrade_base.gd"

func upgrade():
	match upgrade_level:
		0:
			Global.base_max_ammo = 15
		1:
			Global.base_max_ammo = 20
		2:
			Global.base_max_ammo = 25
