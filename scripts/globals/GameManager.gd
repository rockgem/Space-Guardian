extends Node
# GLOBAL ------------------ !!




signal bullet_changed
signal powerup_gained
signal enemy_destroyed


enum POWERUP_TYPE{
	UPGRADE,
	HEALTH,
	SHIELD
}


var object_gravity: float = 40

var current_bullet_level: int = 1
var max_bullet_level: int = 6
var player_damage: int = 1
var player_health: int = 5
var player_attack_speed: float = 0.3


func powerup_gain(type: int):
	match type:
		0: 
			if current_bullet_level >= max_bullet_level:
				return
			current_bullet_level += 1
			emit_signal("bullet_changed")
