extends KinematicBody2D



var move_speed = 160
var velocity: Vector2
var can_fire: bool = false

var bullet = load("res://actors/objects/Bullet.tscn")


func _ready():
	GameManager.connect("bullet_changed", self, 'on_bullet_changed')
	$AttackTimer.wait_time = GameManager.player_attack_speed


func _physics_process(delta):
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	velocity = move_and_slide(velocity * move_speed)


func _unhandled_key_input(event):
	if Input.is_action_just_pressed("fire"):
		can_fire = true
		$AttackTimer.start()
	elif Input.is_action_just_released("fire"):
		can_fire = false
		$AttackTimer.stop()


func on_bullet_changed():
	pass
#	bullet.change_bullet()


func _on_AttackTimer_timeout():
	if can_fire == false:
		return
	elif GameManager.bullets <= 0:
		return
	
	GameManager.bullets -= 1
	$BulletSFX.play()
	if GameManager.current_bullet_level >= 3:
		var b2 = bullet.instance()
		var b3 = bullet.instance()
		b2.global_position = $BulletSpawner2.global_position
		b3.global_position = $BulletSpawner3.global_position
		get_tree().root.add_child(b2)
		get_tree().root.add_child(b3)
		
		return
	
	var b = bullet.instance()
	b.global_position = $BulletSpawner.global_position
	
	get_tree().root.add_child(b)


func _on_Hurtbox_area_entered(area):
	GameManager.player_health -= 1
	area.get_parent().queue_free()
