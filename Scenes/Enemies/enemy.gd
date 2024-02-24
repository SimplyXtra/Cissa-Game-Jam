extends CharacterBody2D

@export var speed: int = 30
@export var health: int = 100
@export var damage: int = 20
@export_enum("North", "South", "East", "West") var spawnLocation:int

signal dropItem(location)

func _ready():
	match spawnLocation:
		0:
			velocity = speed * Vector2.DOWN
			$Sprite2D.rotation = 90
		1:
			velocity = speed * Vector2.UP
			$Sprite2D.rotation = -90
		2:
			velocity = speed * Vector2.LEFT
			$Sprite2D.rotation = 180
		3:
			velocity = speed * Vector2.RIGHT

func _process(_delta):
	move_and_slide()

func take_damage(damageAmount:int):
	health -= damageAmount
	if health <= 0:
		if randi()%3 == 0:
			dropItem.emit(position)
		queue_free()

func _on_hitbox_body_entered(body):
	take_damage(body.damage)
	body.hit_enemy()
