extends Sprite




# the only difference between the player's bullet and this
# is the area2D between them masks different layers
# and they also go towards different directions

func _physics_process(delta):
	position.y += 250 * delta


func change_bullet():
	texture = load("res://assets/bullets/projectile%s.png" % str(GameManager.current_bullet_level))


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
