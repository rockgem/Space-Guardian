extends Node2D



func _ready():
	GameManager.connect("scroll_stopped", self, 'on_scroll_stopped')


func on_scroll_stopped():
	set_physics_process(false)


func _physics_process(delta):
	position.y += 30 * delta
	
	if position.y >= 320:
		position.y = 0
