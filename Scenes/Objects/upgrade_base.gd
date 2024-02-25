extends Node2D
var upgrade_level:int = 0
@export var prices := [[1,0,0,0],[0,2,0,0],[3,0,0,0]]

func _process(_delta):
	if $Prices.visible:
		if Input.is_action_just_pressed("interact"):
			var compiled_storage := [Global.energy_collected, Global.matter_collected, Global.weird_collected, Global.cool_collected]
			var can_upgrade:bool = true
			for i in range(4):
				if compiled_storage[i] < prices[upgrade_level][i]:
					can_upgrade = false
			if can_upgrade: 
				upgrade()
				$Sprite2D.frame += 1
				$Upgrade.play()
				Global.energy_collected -= prices[upgrade_level][0]
				Global.matter_collected -= prices[upgrade_level][1]
				Global.weird_collected -= prices[upgrade_level][2]
				Global.cool_collected -= prices[upgrade_level][3]
				upgrade_level += 1
				$Prices.set_prices(prices[upgrade_level][0],prices[upgrade_level][1],prices[upgrade_level][2],prices[upgrade_level][3])
				Global.quick_update_UI()

func upgrade():
	print("upgraded")

func _on_pressure_plate_body_entered(_body):
	$Prices.set_prices(prices[upgrade_level][0],prices[upgrade_level][1],prices[upgrade_level][2],prices[upgrade_level][3])
	$Prices.visible = true
	#Get Input "interact"
	#UI Progress bar increases as interact is pressed and when full it goes through but if let go it goes back to 0
	


func _on_pressure_plate_body_exited(_body):
	$Prices.visible = false
