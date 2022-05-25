extends Sprite



func _physics_process(delta):
	position.y -= 200 * delta


func _on_VisibilityNotifier2D_screen_exited():
	print('bullet freed')
	queue_free()
