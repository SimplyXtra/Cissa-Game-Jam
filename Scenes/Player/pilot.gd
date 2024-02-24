extends CharacterBody2D
var speed:int = 100
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
			var direction:float = Input.get_action_strength("down") - Input.get_action_strength("up")
			$AnimationTree.set("parameters/Vertical/blend_position", direction)
			velocity.y = speed * direction
			if direction == 0:
				$AnimationTree.set("parameters/conditions/Idle", true)
				$AnimationTree.set("parameters/conditions/Vertical", false)
			else:
				$AnimationTree.set("parameters/conditions/Vertical", true)
				$AnimationTree.set("parameters/conditions/Idle", false)
		horizontal:
			var direction:float = Input.get_action_strength("right") - Input.get_action_strength("left")
			$AnimationTree.set("parameters/Horizontal/blend_position", direction)
			velocity.x = speed * direction
			if direction == 0:
				$AnimationTree.set("parameters/conditions/Idle", true)
				$AnimationTree.set("parameters/conditions/Horizontal", false)
			else:
				$AnimationTree.set("parameters/conditions/Horizontal", true)
				$AnimationTree.set("parameters/conditions/Idle", false)


func _on_item_pickup_body_entered(body):
	Global.add(body.item_drop)
	body.queue_free()
