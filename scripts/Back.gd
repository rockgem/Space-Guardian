extends Node2D


# this is where the background happens
# it automatically scrolls down as physics_process happens



# NOTE -------------------------------
# this 4 children of this node is used for infinite scrolling,
# if you have an entire design background, you can delete the other 3 the and
# disable a code in the physics_process

var limit
var mid_limit
var level_parent

func _ready():
	GameManager.connect("scroll_stopped", self, 'on_scroll_stopped')
	GameManager.connect("scroll_activated", self, 'on_scroll_activated')
	
	level_parent = get_parent().get_parent()


func set_background(texture: Texture):
	$Back1.texture = texture
	$Back1.offset.y = -texture.get_height()
	$Back1.offset.y += 320
	
	limit = texture.get_height() - 320
	mid_limit = texture.get_height() / 2


func on_scroll_stopped():
	set_physics_process(false)


func on_scroll_activated():
	set_physics_process(true)


func _physics_process(delta):
	
	# this controls the speed of the background
	# 30 is the current speed, please change this as you wish
	position.y += 30 * delta
	
	if level_parent.is_miniboss_spawned == false:
		if position.y >= mid_limit:
			level_parent.is_miniboss_spawned = true
			get_parent().get_parent().spawn_boss(true)
	
	if position.y >= limit:
		# this calls the Level.tscn fucntion spawn_boss()
		get_parent().get_parent().spawn_boss()
	
	# this code will make the background scroll infinitely
	# if you have a full pre-design an entire background for this
	# you just need to disable this block of code here
#	if position.y >= 320:
#		position.y = 0
