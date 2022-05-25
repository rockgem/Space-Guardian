extends KinematicBody2D



var move_speed = 100
var velocity: Vector2

var bullet = load("res://actors/objects/Bullet.tscn")


func _ready():
	$AttackTimer.wait_time = GameManager.player_attack_speed


func _physics_process(delta):
	velocity.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	velocity.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	velocity = move_and_slide(velocity * move_speed)


func _on_AttackTimer_timeout():
	var b = bullet.instance()
	b.global_position = $BulletSpawner.global_position
	
	get_tree().root.add_child(b)
	
