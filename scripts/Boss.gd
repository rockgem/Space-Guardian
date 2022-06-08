extends Sprite


var bullet = load("res://actors/objects/EnemyBullet.tscn")

var hp: int = 400
#var move_speed: float = 70
var dir = -1 # direction -1 going left and 1 to the right(used in tweening)
var is_mini_boss: bool = false


func _ready():
	GameManager.connect("boss_destroyed", self, 'death')
#	set_physics_process(true)
	
	$Tween.interpolate_property(self, 'position:y', position.y - 40, position.y, 1.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()


func set_attributes(att: Dictionary):
	hp = att['hp']
	$AttackTimer.wait_time = att['attack_timer']
	$AttackCooldown.wait_time = att['attack_cooldown']
	$AttackDuration.wait_time = att['attack_duration']


func death():
	set_physics_process(false)
	$AttackTimer.stop()
	$AttackCooldown.stop()
	$AttackDuration.stop()
	queue_free()


func _on_AttackTimer_timeout():
	var b = bullet.instance()
	var b2 = bullet.instance()
	var b3 = bullet.instance()
	var b4 = bullet.instance()
	b.global_position = $BulletSpawner.global_position
	b2.global_position = $BulletSpawner2.global_position
	b3.global_position = $BulletSpawner3.global_position
	b4.global_position = $BulletSpawner4.global_position
	
	get_tree().root.add_child(b)
	get_tree().root.add_child(b2)
	get_tree().root.add_child(b3)
	get_tree().root.add_child(b4)


func _on_AttackCooldown_timeout():
	if $AttackTimer.is_stopped():
#		set_physics_process(false)
		$AttackTimer.start()
		$AttackDuration.start()
	else:
#		set_physics_process(true)
		$AttackTimer.stop()
	
	$Tween.interpolate_property(get_parent(), 'offset', get_parent().offset, 140 * dir, 2, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()
	if dir == -1:
		dir = 1
	else:
		dir = -1


func _on_AttackDuration_timeout():
	$AttackTimer.stop()


func _on_HurtBox_area_entered(area):
	hp -= GameManager.player_damage
	GameManager.emit_signal("enemy_destroyed", area.get_parent().global_position)
	area.get_parent().queue_free()
	
	# this whole block could be changed lmao no time to do so my back hurts
	if hp <= 0:
		if is_mini_boss:
			GameManager.emit_signal("mini_boss_destroyed")
			death()
			return
		
		GameManager.emit_signal("boss_destroyed") # this signal is connected to this node














