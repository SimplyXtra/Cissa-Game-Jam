extends Node
const BASE_MAX_HEALTH:int = 200
const BASE_MAX_AMMO:int = 10
const BULLET_PENETRATION:int = 1
const BULLET_RELOAD_TIME:float = 1.0
var base_max_health:int = BASE_MAX_HEALTH:
	set(new_max_health):
		base_max_health = new_max_health
		update_UI.emit()
var base_health:int = base_max_health: 
	set(new_health):
		base_health = new_health
		update_UI.emit()
var base_max_ammo:int = BASE_MAX_AMMO:
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
var bullet_penetration:int = 1
var bullet_level:int = 0
var bullet_reload_time:float = 1.0
var score:int = 0
var high_score:int = 0
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

func quick_update_UI() -> void:
	update_UI.emit()



func reset() -> void:
	high_score = max(score, high_score)
	base_max_health = BASE_MAX_HEALTH
	base_health = base_max_health
	base_max_ammo = BASE_MAX_AMMO
	base_ammo = base_max_ammo
	energy_collected = 0
	matter_collected = 0
	weird_collected = 0
	cool_collected = 0
	bullet_penetration = BULLET_PENETRATION
	bullet_level = 0
	bullet_reload_time = BULLET_RELOAD_TIME
	score = 0
	quick_update_UI()
