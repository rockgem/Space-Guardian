extends Sprite






func _physics_process(delta):
	global_position.y += 100 * delta



func _on_Area2D_area_entered(area):
	GameManager.emit_signal("enemy_destroyed", global_position)
	queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
