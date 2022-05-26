extends Node2D



func _physics_process(delta):
	position.y += 30 * delta
	
	if position.y >= 320:
		position.y = 0
