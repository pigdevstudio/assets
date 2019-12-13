extends Node

"""
Description:
	A container for AudioStreamPlayers that allows to play predefined
	AudioStreams simply passing the AudioStreamPlayer name, or letting
	a random one be played.
Notes:
	This can be used in Node2D and Spatial nodes, e.g. if you want
	to use AudioStreamPlayer2D, add a Node2D as parent of the
	AudioStreamPlayer2Ds and drag this script as is in the parent.
"""

onready var current_sfx = get_child(0)

func play(sfx_name = "random_sfx"):
	if has_node(sfx_name):
		current_sfx = get_node(sfx_name)
	else:
		var rand_child = randi()%get_child_count()
		current_sfx = get_child(rand_child)
	current_sfx.play()


func pause(sfx_name = "current"):
	if not sfx_name == "current" and has_node(sfx_name):
		get_node(sfx_name).stream_paused = true
	else:
		current_sfx.stream_paused = true


func pause_all():
	for child in get_children():
		child.stream_paused = true


func unpause(sfx_name = "current"):
	if not sfx_name == "current" and has_node(sfx_name):
		get_node(sfx_name).stream_paused = false
	else:
		current_sfx.stream_paused = false


func unpause_all():
	for child in get_children():
		child.stream_paused = false


func stop(sfx_name = "current"):
	if not sfx_name == "current" and has_node(sfx_name):
		get_node(sfx_name).stop()
	else:
		current_sfx.stop()


func stop_all():
	for child in get_children():
		child.stop()
