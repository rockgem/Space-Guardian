extends Panel

var music_bus = AudioServer.get_bus_index('Music')
var sfx_bus = AudioServer.get_bus_index('SFX')


func _ready():
	$VBoxContainer/Music/HSlider.value = db2linear(AudioServer.get_bus_volume_db(music_bus))
	$VBoxContainer/SFX/HSlider.value = db2linear(AudioServer.get_bus_volume_db(sfx_bus))





