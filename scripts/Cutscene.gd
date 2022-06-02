extends Control


var current_dialog: String = ''
var current_dialog_data: Dictionary
var current_dialog_keys: Array = []
var current_dialog_index: int = 0


var tween

func _ready():
	tween = Tween.new()
	add_child(tween)
	
	var mymaterial = $CanvasLayer/Transition.get('material')
	tween.interpolate_property(mymaterial, 'shader_param/progress', 1, 0, 3.0, Tween.TRANS_CUBIC, Tween.EASE_OUT) 
	tween.start()
	
	load_dialog_data('dialog_level%s_data' % str(GameManager.current_level))


func load_dialog_data(dialog_id: String):
	var file = File.new()
	if file.open("res://resources/cutscenes_data/%s.json" % dialog_id, file.READ) == OK:
		print('file exists')
		current_dialog_data = parse_json(file.get_as_text())
	else:
		print('file does not exists')
	file.close()
	
	current_dialog_keys = current_dialog_data.keys()
	
	dialog_pop()


func dialog_pop():
	if current_dialog_index > current_dialog_keys.size() - 1:
		dialog_all_finish()
		return
	
	$Dialog.visible_characters = 0
	$Dialog.show()
	$Face1.show()
	
	$Dialog.text = current_dialog_data[current_dialog_keys[current_dialog_index]]['dialog']
	
	$DialogTimer.start()
	
	current_dialog_index += 1


func dialog_all_finish():
	var mymaterial = $CanvasLayer/Transition.get('material')
	tween.interpolate_property(mymaterial, 'shader_param/progress', 0, 1, 3.0, Tween.TRANS_CUBIC, Tween.EASE_OUT) 
	tween.start()
	
	yield(tween, "tween_all_completed")
	
	get_tree().change_scene("res://scenes/Level1.tscn")
	
	


func _on_DialogTimer_timeout():
	$Dialog.visible_characters += 1
	
	if $Dialog.percent_visible >= 1:
		$DialogTimer.stop()


func _on_Cutscene_gui_input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_LEFT:
		dialog_pop()
