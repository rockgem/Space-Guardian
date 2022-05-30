extends Control





func _ready():
	$TextureProgress.value = GameManager.bullets
	$TextureProgress.max_value = GameManager.max_bullets
	$Hp.value = GameManager.player_health
	$Hp.max_value = GameManager.player_health


func _physics_process(delta):
	$TextureProgress.value = GameManager.bullets
	$Hp.value = GameManager.player_health


func _on_Options_pressed():
	var o = load("res://actors/ui/Options.tscn").instance()
	
	$CanvasLayer.add_child(o)










