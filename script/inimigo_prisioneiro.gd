extends inimigo


func _movement() -> void:
	if is_alive:
		motion.x = -SPEED * dir
	else:
		motion.x = 0

func _ataque() -> void:
	pass
