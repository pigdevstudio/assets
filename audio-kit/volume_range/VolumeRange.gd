extends Range

"""
Description:
	A Range that affects Audio Buses's volumes, allowing for linear
	setting the Audio Bus' volume
"""

export(String) var audio_bus = "Master"


func _ready():
	var bus = AudioServer.get_bus_index(audio_bus)
	var volume_db = AudioServer.get_bus_volume_db(bus)
	value = db2linear(volume_db) * 100
	
	connect("value_changed", self, "_on_value_changed")


func _on_value_changed(value):
	var bus = AudioServer.get_bus_index(audio_bus)
	AudioServer.set_bus_volume_db(bus, linear2db(value * 0.01))
