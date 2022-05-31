extends Node2D



var powerup = load("res://actors/objects/Powerup.tscn")
var explosion = load("res://actors/objects/Explosion.tscn")
var enemy = load("res://actors/entities/Enemy.tscn")
var enemy_group = load("res://actors/entities/EnemyGroup.tscn")

var rng = RandomNumberGenerator.new()
onready var custom_paths = [$CurveSideRight, $CurveSideLeft, $U, $Sides]




func _ready():
	GameManager.connect("enemy_destroyed", self, 'on_enemy_destroyed')
	GameManager.connect("boss_destroyed", self, 'on_boss_destroyed')
	
	var player = load("res://actors/entities/Player.tscn").instance()
	player.global_position = $Spawn.global_position
	
	$YSort.add_child(player)


# this function is used to spawn explosions
# the explosion happens from where the destroyed enemy's position was
func on_enemy_destroyed(pos: Vector2):
	get_tree().root.get_node("/root/Sfx/Explosion").play()
	var e = explosion.instance()
	e.global_position = pos
	
	$YSort.add_child(e)


func on_boss_destroyed():
	pass


# generates a powerup and places it randomly between 3 specific points
func add_powerup():
	randomize()
	var rand = randi() % $Locations.get_child_count()
	
	var np = powerup.instance()
	np.position = $Locations.get_child(rand).global_position
	
	$YSort.add_child(np)


func change_level():
	get_tree().change_scene("res://scenes/Level1.tscn")


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


# once this timer pops a boss/miniboss should appear to end the level
# and would emit a signal that would stop the background from scrolling
func _on_LevelTimer_timeout():
	$EnemyTimer.stop()
	GameManager.emit_signal("scroll_stopped") # Player.tscn's 'Back' node  listens to this signal
	
	var boss = load("res://actors/entities/Boss.tscn").instance()
	$BossMove/PathFollow2D.add_child(boss)
	$LevelTimer.stop()
















