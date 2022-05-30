extends Panel

var music_bus = AudioServer.get_bus_index('Music')
var sfx_bus = AudioServer.get_bus_index('SFX')


func _ready():
	$VBoxContainer/Music/MusicSlider.value = db2linear(AudioServer.get_bus_volume_db(music_bus))
	$VBoxContainer/SFX/SFXSlider.value = db2linear(AudioServer.get_bus_volume_db(sfx_bus))


func _on_MusicSlider_value_changed(value):
	var val = linear2db(value)
	AudioServer.set_bus_volume_db(music_bus, val)


func _on_SFXSlider_value_changed(value):
	var val = linear2db(value)
	AudioServer.set_bus_volume_db(sfx_bus, val)
