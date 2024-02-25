extends CharacterBody2D

@export var speed: int = 30
@export var health: int = 100
@export var damage: int = 20
@export_enum("North", "South", "East", "West") var spawnLocation:int
var is_dead:bool = false

signal dropItem(location)

func _ready():
	match spawnLocation:
		0:
			$Sprite2D.rotation = 90
		1:
			$Sprite2D.rotation = -90
		2:
			$Sprite2D.rotation = 180
	velocity = speed * (Global.base_position - position).normalized()

func _process(_delta):
	if not is_dead: move_and_slide()

func take_damage(damageAmount:int):
	if not is_dead:
		health -= damageAmount
		
		if health <= 0:
			is_dead = true
			#$Hitbox.set_collision_mask_value(3, false)
			#set_collision_layer_value(1, false)
			#set_collision_mask_value(2, false)
			if randi()%3 != 0 and damageAmount != 999:
				dropItem.emit(position)
			$DeathSound.play()
			visible = false
			await $DeathSound.finished
			queue_free()
		else:
			$HitSound.play()

func _on_hitbox_area_entered(area):
	if not is_dead:
		area.hit_enemy()
		take_damage(area.damage)
