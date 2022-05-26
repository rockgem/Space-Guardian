extends Sprite

var type: int

# randomize what type this is
# everytime a powerup is produced in the game
# this ready function will randomize what type of powerup it is going to be
func _ready():
	randomize()
	var rand = randi() % GameManager.POWERUP_TYPE.size()
	
	type = rand
	
	texture = load("res://assets/items/powerup%s.png" % str(type))


func _physics_process(delta):
	position.y += GameManager.object_gravity * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_body_entered(body):
	GameManager.powerup_gain(type)
	queue_free()
