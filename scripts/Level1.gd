extends Node2D



var powerup = load("res://actors/objects/Powerup.tscn")


func _ready():
	var player = load("res://actors/entities/Player.tscn").instance()
	player.global_position = $Spawn.global_position
	
	$YSort.add_child(player)


func add_powerup():
	randomize()
	var rand = randi() % $Locations.get_child_count()
	
	var np = powerup.instance()
	np.position = $Locations.get_child(rand).global_position
	
	$YSort.add_child(np)


func _on_PowerupTimer_timeout():
	add_powerup()
