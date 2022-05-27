extends Sprite


#func _ready():
#	texture = load("res://assets/bullets/projectile%s.png" % str(GameManager.current_bullet_level))

func _physics_process(delta):
	position.y += 250 * delta


func change_bullet():
	texture = load("res://assets/bullets/projectile%s.png" % str(GameManager.current_bullet_level))


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
