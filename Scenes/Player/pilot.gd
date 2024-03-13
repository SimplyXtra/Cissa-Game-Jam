extends CharacterBody2D
var speed:int = 120
var fleeing_speed:int = 180
var is_running_to_base:bool = false
enum {
	vertical,
	horizontal
}
var fixedDirection = vertical


func _process(delta):
	move(delta)
	move_and_slide()


func set_direction(direction:String) -> void:
	if direction == "horizontal":
		fixedDirection = horizontal
		$AnimationTree.set("parameters/conditions/Vertical", false)
		$AnimationTree.set("parameters/conditions/Idle", true)
	elif direction == "vertical":
		fixedDirection = vertical
		$AnimationTree.set("parameters/conditions/Horizontal", false)
		$AnimationTree.set("parameters/conditions/Idle", true)

func move(_delta) -> void:
	match fixedDirection:
		vertical:
			var direction:float
			if not is_running_to_base:
				direction = Input.get_action_strength("down") - Input.get_action_strength("up")
				velocity.y = speed * direction
			else:
				direction = (Global.base_position - position).normalized().y
				velocity.y = fleeing_speed * direction
			$AnimationTree.set("parameters/Vertical/blend_position", direction)
			if direction == 0:
				$AnimationTree.set("parameters/conditions/Idle", true)
				$AnimationTree.set("parameters/conditions/Vertical", false)
			else:
				$AnimationTree.set("parameters/conditions/Vertical", true)
				$AnimationTree.set("parameters/conditions/Idle", false)
		horizontal:
			var direction:float
			if not is_running_to_base:
				direction = Input.get_action_strength("right") - Input.get_action_strength("left")
				velocity.x = speed * direction
			else:
				direction = (Global.base_position - position).normalized().x
				velocity.x = fleeing_speed * direction
			$AnimationTree.set("parameters/Horizontal/blend_position", direction)
			if direction == 0:
				$AnimationTree.set("parameters/conditions/Idle", true)
				$AnimationTree.set("parameters/conditions/Horizontal", false)
			else:
				$AnimationTree.set("parameters/conditions/Horizontal", true)
				$AnimationTree.set("parameters/conditions/Idle", false)

func _on_item_pickup_body_entered(body):
	Global.add(body.item_drop)
	$Pickup.play()
	body.queue_free()


func _on_enemy_radar_body_entered(_body):
	is_running_to_base = true
	$Alert.play()
	$EnemyRadar/AnimationPlayer.play("Alert")
	#Drop items if got time
