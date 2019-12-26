extends Node

export (String, DIR) var source_directory

func _ready():
	play()
	
func play(sfx = null):
	if sfx:
		get_node(sfx).play()
	else:
		get_child(randi()%get_child_count()).play()