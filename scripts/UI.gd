extends Control





func _ready():
	GameManager.connect("player_destroyed", self, 'on_player_destroyed')
	GameManager.connect("level_success", self, 'on_level_success')
	
	$TextureProgress.value = GameManager.bullets
	$TextureProgress.max_value = GameManager.max_bullets
	$Hp.value = GameManager.player_health
	$Hp.max_value = GameManager.player_health


func _physics_process(delta):
	$TextureProgress.value = GameManager.bullets
	$Hp.value = GameManager.player_health


func on_player_destroyed():
	$GameoverPanel.show()


func on_level_success():
	$CanvasLayer/LevelSuccesPanel.show()
	var tween = Tween.new()
	add_child(tween)
	
	var mymaterial = $CanvasLayer/Transition.get('material')
	tween.interpolate_property(mymaterial, 'shader_param/progress', 0, 1, 3.0, Tween.TRANS_CUBIC, Tween.EASE_OUT, 3.0) 
	tween.start()
	
	yield(tween, "tween_all_completed")
	
	get_tree().change_scene("res://scenes/Cutscene.tscn")


func _on_Options_pressed():
	var o = load("res://actors/ui/Options.tscn").instance()
	$CanvasLayer.add_child(o)


func _on_Restart_pressed():
	GameManager.reset_game()
	get_tree().change_scene("res://scenes/Level1.tscn")
