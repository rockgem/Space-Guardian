extends Sprite


var bullet = load("res://actors/objects/EnemyBullet.tscn")

var hp: int = 400
var move_speed: float = 70
var dir = -1


func _ready():
	GameManager.connect("boss_destroyed", self, 'death')
	
	$Tween.interpolate_property(self, 'position:y', null, position.y + 100, 1.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	$Tween.start()


func _physics_process(delta):
	pass


func death():
	set_physics_process(false)
	$AttackTimer.stop()
	$AttackCooldown.stop()
	$AttackDuration.stop()


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
		$AttackTimer.start()
		$AttackDuration.start()
	else:
		$AttackTimer.stop()
	
	$Tween.interpolate_property(self, 'position:x', null, (position.x + 40) * dir, 1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
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
	
	if hp <= 0:
		GameManager.emit_signal("boss_destroyed")














