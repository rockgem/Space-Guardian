extends Control



func _on_PanelBase_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		queue_free()
