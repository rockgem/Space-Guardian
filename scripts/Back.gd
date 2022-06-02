extends Node2D


# this is where the background happens
# it automatically scrolls down as physics_process happens



# NOTE -------------------------------
# this 4 children of this node is used for infinite scrolling,
# if you have an entire design background, you can delete the other 3 the and
# disable a code in the physics_process

func _ready():
	GameManager.connect("scroll_stopped", self, 'on_scroll_stopped')


func on_scroll_stopped():
	set_physics_process(false)


func _physics_process(delta):
	
	# this controls the speed of the background
	# 30 is the current speed, please change this as you wish
	position.y += 30 * delta
	
	
	# this code will make the background scroll infinitely
	# if you have a full pre-design an entire background for this
	# you just need to disable this block of code here
	if position.y >= 320:
		position.y = 0
