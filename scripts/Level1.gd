extends Node2D



export(Texture) var background_texture

var powerup = load("res://actors/objects/Powerup.tscn")
var explosion = load("res://actors/objects/Explosion.tscn")
var enemy = load("res://actors/entities/Enemy.tscn")
var enemy_group = load("res://actors/entities/EnemyGroup.tscn")

var rng = RandomNumberGenerator.new()
onready var custom_paths = [$CurveSideRight, $CurveSideLeft, $U, $Sides]
onready var custom_miniboss_paths = [$BossMove, $BossMove2, $BossMove3]

var is_miniboss_spawned: bool = false


func _ready():
	GameManager.connect("enemy_destroyed", self, 'on_enemy_destroyed')
	GameManager.connect("boss_destroyed", self, 'on_boss_destroyed')
	GameManager.connect("mini_boss_destroyed", self, 'on_mini_boss_destroyed')
	
	var player = load("res://actors/entities/Player.tscn").instance()
	player.global_position = $Spawn.global_position
	
	$YSort.add_child(player)
	
	GameManager.reset_game()
	
	set_background(background_texture)


func set_background(texture: Texture):
	$CanvasLayer/Back.set_background(texture)


# this function is used to spawn explosions
# the explosion happens from where the destroyed enemy's position was
func on_enemy_destroyed(pos: Vector2):
	get_tree().root.get_node("/root/Sfx/Explosion").play()
	var e = explosion.instance()
	e.global_position = pos
	
	$YSort.add_child(e)


func on_boss_destroyed():
	GameManager.emit_signal("level_success")


func on_mini_boss_destroyed():
	GameManager.emit_signal("scroll_activated")


# generates a powerup and places it randomly between 3 specific points
func add_powerup():
	randomize()
	var rand = randi() % $Locations.get_child_count()
	
	var np = powerup.instance()
	np.position = $Locations.get_child(rand).global_position
	
	$YSort.add_child(np)


func change_level():
	get_tree().change_scene("res://scenes/Level1.tscn")


func spawn_boss(is_miniboss: bool = false, boss_attributes: Dictionary = {}):
	var mini_boss_attributes_template = {
		'hp': 100,
		'attack_timer': 0.2,
		'attack_cooldown': 2.0,
		'attack_duration': 10.0
	}
	
	$EnemyTimer.stop()
	GameManager.emit_signal("scroll_stopped") 
	
	# gives the miniboss different movement path
	# essentialy, a mini boss is just a Boss.tscn but with different
	# set of attributes, try playing around with the set_attributes() function
	if is_miniboss:
		randomize()
		var rand = randi() % custom_miniboss_paths.size() - 1
		var random_path = custom_miniboss_paths[rand]
		var boss = load("res://actors/entities/Boss.tscn").instance()
		boss.is_mini_boss = true
		boss.set_attributes(mini_boss_attributes_template)
		random_path.get_node('PathFollow2D').add_child(boss)
		return
	
	var boss = load("res://actors/entities/Boss.tscn").instance()
	$BossMove/PathFollow2D.add_child(boss)


func _on_PowerupTimer_timeout():
	add_powerup()
	
	# generates random spawn times for powerups
	rng.randomize()
	var rand = rng.randf_range(2, 10) 
	$PowerupTimer.wait_time = rand


# this function generates enemies throughout the game
# there are currently 2 types of enemies, Single, and Grouped enemies
# please see Enemy.tscn, EnemyGroup.tscn in actors/entities folder
func _on_EnemyTimer_timeout():
	randomize()
	var rand_e = randi() % 2
	var rand
	var e
	
	var rand_path = randi() % custom_paths.size() - 1
	
	
	if rand_e == 0:
		e = enemy.instance()
	else:
		e = enemy_group.instance()
		# randomises the amount of enemies in a group
		rand = rng.randi_range(3, 6)
		e.set_amount(rand)
		e.position.x = rng.randf_range(-40, 40)
		
		$EnemySpawner.add_child(e)
		return
	
	# randomly offsets the generated groups of enemies
	# in the x axis
#	e.position.x = rng.randf_range(-40, 40)
	
	custom_paths[rand_path].get_child(0).add_child(e)














