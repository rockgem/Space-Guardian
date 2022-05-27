extends Node
# GLOBAL ------------------ !!




signal bullet_changed
signal powerup_gained
signal enemy_destroyed
signal scroll_stopped
signal boss_destroyed

# this is kinda useless tbh, i just 
# put this here for reference
enum POWERUP_TYPE{
	UPGRADE,
	SHIELD,
	BULLET,
	HEALTH
}
# ------------------------------

var object_gravity: float = 40

var current_bullet_level: int = 1
var max_bullet_level: int = 6
var bullets: int = 200
var max_bullets:int = 400
var player_damage: int = 1
var player_health: int = 5
var player_attack_speed: float = 0.1


func powerup_gain(type: int):
	match type:
		1: 
			if current_bullet_level >= max_bullet_level:
				return
			current_bullet_level += 1
			player_damage += 1
			emit_signal("bullet_changed")
		2:
			bullets += 100
			if bullets >= max_bullets:
				bullets = max_bullets
		3:
			player_health += 1
			if player_health >= 5:
				player_health = 5













