extends Sprite


var bullet = load("res://actors/objects/EnemyBullet.tscn")

var move_speed: float = 70


func _ready():
	var tween = Tween.new()
	add_child(tween)
	
	tween.interpolate_property(self, 'position:y', null, position.y + 100, 1.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()


func _physics_process(delta):
	pass


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


func _on_AttackDuration_timeout():
	$AttackTimer.stop()
