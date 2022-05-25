extends Node
# GLOBAL ------------------ !!



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
