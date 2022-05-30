extends Node2D



var amount: int


func _ready():
	for child in get_children():
		child.connect('custom_exit', self, 'on_custom_exit')
		child.set_physics_process(false)


func _physics_process(delta):
#	global_position.y += 100 * delta
	get_parent().offset += 100 * delta


func set_amount(amount: int):
	if amount == 3:
		$Enemy4.queue_free()
		$Enemy5.queue_free()
		$Enemy6.queue_free()
	elif amount == 4:
		$Enemy5.queue_free()
		$Enemy6.queue_free()
	elif amount == 5:
		$Enemy3.queue_free()


func on_custom_exit():
	amount =+ 1
	if amount >= get_child_count():
		queue_free()
