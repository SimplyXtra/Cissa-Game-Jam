extends Node
var base_max_health:int = 1000:
	set(new_max_health):
		base_max_health = new_max_health
		update_UI.emit()
var base_health:int = base_max_health: 
	set(new_health):
		base_health = new_health
		update_UI.emit()
var base_max_ammo:int = 10:
	set(new_max_ammo):
		base_max_ammo = new_max_ammo
		update_UI.emit()
var base_ammo:int = base_max_ammo:
	set(new_ammo):
		base_ammo = new_ammo
		update_UI.emit()
var base_position:Vector2
var energy_collected:int = 0
var matter_collected:int = 0
var weird_collected:int = 0
var cool_collected:int = 0
signal update_UI

func add(item:String):
	match item:
		"Energy":
			energy_collected += 1
		"Matter":
			matter_collected += 1
		"Weird":
			weird_collected += 1
		"Cool":
			cool_collected += 1
	update_UI.emit()
