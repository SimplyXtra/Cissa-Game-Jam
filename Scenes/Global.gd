extends Node
var base_max_health:int = 1000
var base_health:int = base_max_health: 
	set(new_health):
		base_health = new_health
		update_UI()
var energy_collected:int = 0
var matter_collected:int = 0
var weird_collected:int = 0
var cool_collected:int = 0

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

func update_UI() -> void:
	print(base_health, "/", base_max_health)
