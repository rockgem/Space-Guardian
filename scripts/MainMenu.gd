extends Control




func _on_Play_pressed():
	get_tree().change_scene("res://scenes/Level1.tscn")


func _on_Settings_pressed():
	var o = load("res://actors/ui/Options.tscn").instance()
	
	$CanvasLayer.add_child(o)
