extends Area2D
#Shooting
var bullets:Array = [preload("res://Scenes/Projectiles/basic_bullet.tscn"),preload("res://Scenes/Projectiles/party_bullet.tscn"),preload("res://Scenes/Projectiles/spike_bullet.tscn"),preload("res://Scenes/Projectiles/radio_bullet.tscn")]

#Player-Base Interaction
var pilot:PackedScene = preload("res://Scenes/Player/pilot.tscn")
var is_player_in_base:bool = true
var is_base_active:bool = true

var is_base_alive:bool = true
signal dead

func _ready() -> void:
	$UI.visible = false
	$Sprite2D.frame = 2
	is_player_in_base = true
	is_base_active = true
	Global.base_position = position

func _process(_delta) -> void:
	if is_base_alive:
		if Input.is_action_just_pressed("interact") and is_player_in_base:
			is_base_active = not is_base_active
			$Audio/Detach.play()
			
			#Player is controlling base
			if is_base_active:
				$Sprite2D.frame = 2
				$UI.visible = false
				
			#Player is not controlling base
			else:
				$Sprite2D.frame = 1
				$UI.visible = true
		elif not is_base_active and is_player_in_base:
			#Player selects where to go
			if Input.is_action_just_pressed("up"):
				player_leaves_base($PlayerSpawnLocations/North.global_position, "vertical")
			elif Input.is_action_just_pressed("down"):
				player_leaves_base($PlayerSpawnLocations/South.global_position, "vertical")
			elif Input.is_action_just_pressed("left"):
				player_leaves_base($PlayerSpawnLocations/West.global_position, "horizontal")
			elif Input.is_action_just_pressed("right"):
				player_leaves_base($PlayerSpawnLocations/East.global_position, "horizontal")
		elif is_base_active and is_player_in_base and Global.base_ammo > 0:
			#Player selects where to shoot
			if Input.is_action_just_pressed("up"):
				shoot($PlayerSpawnLocations/North.global_position, Vector2.UP)
			if Input.is_action_just_pressed("down"):
				shoot($PlayerSpawnLocations/South.global_position, Vector2.DOWN)
			if Input.is_action_just_pressed("left"):
				shoot($PlayerSpawnLocations/West.global_position, Vector2.LEFT)
			if Input.is_action_just_pressed("right"):
				shoot($PlayerSpawnLocations/East.global_position, Vector2.RIGHT)

func shoot(location:Vector2, direction:Vector2) -> void:
	var projectile = bullets[Global.bullet_level].instantiate()
	projectile.position = location
	projectile.set_direction(direction)
	get_parent().add_child(projectile)
	Global.base_ammo -= 1
	$Audio/Shoot.play()
	if $ProjectileReloadTimer.get_time_left() == 0:
		$ProjectileReloadTimer.start()

func player_leaves_base(location:Vector2, orientation:String) -> void:
	is_player_in_base = false
	$Audio/Door.play()
	$Sprite2D.frame = 0
	$UI.visible = false
	var player = pilot.instantiate()
	player.position = location
	player.set_direction(orientation)
	get_parent().add_child(player)

func _on_body_entered(body) -> void:
	Global.base_health -= body.damage
	body.take_damage(999)
	$Camera2D.shake(0.5, 8)
	if Global.base_health <= 0 and is_base_alive:
		$Sprite2D.frame = 3
		is_base_alive = false
		$Audio/Die.play()
		dead.emit()
		var death_overlay_scene = load("res://Scenes/UI/death_overlay.tscn")
		var death_overlay = death_overlay_scene.instantiate()
		get_parent().add_child(death_overlay)

func _on_player_enter_locations_body_entered(body):
	body.queue_free()
	$Audio/Door.play()
	if is_base_alive:
		$Sprite2D.frame = 1
		await $Audio/Door.finished
		$Audio/Detach.play()
		$Sprite2D.frame = 2
		is_player_in_base = true
		is_base_active = true


func _on_projectile_reload_timer_timeout():
	if Global.base_ammo < Global.base_max_ammo:
		Global.base_ammo += 1
		$ProjectileReloadTimer.start()
