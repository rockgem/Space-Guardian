extends Node2D



var powerup = load("res://actors/objects/Powerup.tscn")
var explosion = load("res://actors/objects/Explosion.tscn")
var enemy = load("res://actors/entities/Enemy.tscn")


func _ready():
	GameManager.connect("enemy_destroyed", self, 'on_enemy_destroyed')
	
	var player = load("res://actors/entities/Player.tscn").instance()
	player.global_position = $Spawn.global_position
	
	$YSort.add_child(player)


func on_enemy_destroyed(pos: Vector2):
	var e = explosion.instance()
	e.global_position = pos
	
	$YSort.add_child(e)


func add_powerup():
	randomize()
	var rand = randi() % $Locations.get_child_count()
	
	var np = powerup.instance()
	np.position = $Locations.get_child(rand).global_position
	
	$YSort.add_child(np)


func _on_PowerupTimer_timeout():
	add_powerup()


func _on_EnemyTimer_timeout():
	var e = enemy.instance()
	
	$EnemySpawner.add_child(e)




