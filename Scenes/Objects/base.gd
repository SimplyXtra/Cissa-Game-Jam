extends Area2D
#Shooting
var bullet:PackedScene = preload("res://Scenes/Projectiles/basic_bullet.tscn")

#Player-Base Interaction
var pilot:PackedScene = preload("res://Scenes/Player/pilot.tscn")
var is_player_in_base:bool = true
var is_base_active:bool = true


func _ready() -> void:
	$UI.visible = false
	$Sprite2D.frame = 2
	is_player_in_base = true
	is_base_active = true

func _process(_delta) -> void:
	if Input.is_action_just_pressed("interact") and is_player_in_base:
		is_base_active = not is_base_active
		
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
	elif is_base_active and is_player_in_base:
		#Player selects where to go
		if Input.is_action_just_pressed("up"):
			shoot($PlayerSpawnLocations/North.global_position, Vector2.UP)
		if Input.is_action_just_pressed("down"):
			shoot($PlayerSpawnLocations/South.global_position, Vector2.DOWN)
		if Input.is_action_just_pressed("left"):
			shoot($PlayerSpawnLocations/West.global_position, Vector2.LEFT)
		if Input.is_action_just_pressed("right"):
			shoot($PlayerSpawnLocations/East.global_position, Vector2.RIGHT)

func shoot(location:Vector2, direction:Vector2) -> void:
	var projectile = bullet.instantiate()
	projectile.position = location
	projectile.set_direction(direction)
	get_parent().add_child(projectile)

func player_leaves_base(location:Vector2, orientation:String) -> void:
	is_player_in_base = false
	$Sprite2D.frame = 0
	$UI.visible = false
	var player = pilot.instantiate()
	player.position = location
	player.set_direction(orientation)
	get_parent().add_child(player)

func _on_body_entered(body) -> void:
	Global.base_health -= body.damage
	body.take_damage(999)

func _on_player_enter_locations_body_entered(body):
	body.queue_free()
	$Sprite2D.frame = 2
	is_player_in_base = true
	is_base_active = true
