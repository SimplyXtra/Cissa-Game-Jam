extends Area2D
signal damage(dmg)

func _on_body_entered(body):
	damage.emit(999)
