extends Node2D



var amount: int


func _ready():
	# disable the enemy bodies' individual physics_processes
	# we only want this single node's process to move the entire squad of enemies
	for child in get_children():
		child.connect('custom_exit', self, 'on_custom_exit')
		child.set_physics_process(false)
		child.in_a_group = true


# ******** this functionality turned out to be buggy ------------
# we know we needed to .get_parent() here because we are
# going to be adding this node to be a child of PathFollow2D node
# which we will be using to move this enemy in a different varities of patterns
# --------------------------
func _physics_process(delta):
	global_position.y += 100 * delta
#	get_parent().offset += 100 * delta


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
#		get_parent().offset = 0
		queue_free()
