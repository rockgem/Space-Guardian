extends Control





func _ready():
	$TextureProgress.value = GameManager.bullets
	$TextureProgress.max_value = GameManager.max_bullets


func _physics_process(delta):
	$TextureProgress.value = GameManager.bullets


func _on_Options_pressed():
	var o = load("res://actors/ui/Options.tscn").instance()
	
	$CanvasLayer.add_child(o)
