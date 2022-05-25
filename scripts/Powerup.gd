extends Sprite

var type: int

# randomize what type this bitch is
func _ready():
	randomize()
	var rand = randi() % GameManager.POWERUP_TYPE.size()
	
	type = rand
	
	texture = load("res://assets/items/powerup%s.png" % str(type))


func _physics_process(delta):
	position.y += GameManager.object_gravity * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
