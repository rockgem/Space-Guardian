extends Control





func _ready():
	GameManager.connect("player_destroyed", self, 'on_player_destroyed')
	
	$TextureProgress.value = GameManager.bullets
	$TextureProgress.max_value = GameManager.max_bullets
	$Hp.value = GameManager.player_health
	$Hp.max_value = GameManager.player_health


func _physics_process(delta):
	$TextureProgress.value = GameManager.bullets
	$Hp.value = GameManager.player_health


func on_player_destroyed():
	$GameoverPanel.show()


func _on_Options_pressed():
	var o = load("res://actors/ui/Options.tscn").instance()
	
	$CanvasLayer.add_child(o)


func _on_Restart_pressed():
	get_tree().change_scene("res://scenes/Level1.tscn")
