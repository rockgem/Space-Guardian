extends Sprite


signal custom_exit


var hp: int = 3
var path


func _physics_process(delta):
	global_position.y += 100 * delta


func _on_Area2D_area_entered(area):
	hp -= GameManager.player_damage
	area.get_parent().queue_free()
	
	if hp <= 0:
		GameManager.emit_signal("enemy_destroyed", global_position)
		queue_free()


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("custom_exit")
	queue_free()
