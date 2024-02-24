extends CharacterBody2D

@export var damage:int = 80
@export var speed:int = 200
@export var enemy_penetration:int = 1

func _process(_delta):
	move_and_slide()

func set_direction(direction:Vector2):
	velocity = direction * speed

func hit_enemy():
	enemy_penetration -= 1
	if enemy_penetration <= 0:
		queue_free()

func _on_despawn_timer_timeout():
	queue_free()
