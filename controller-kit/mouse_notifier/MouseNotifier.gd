extends Node2D

"""
Description:
	A Node2D that detects when the Mouse clicked on the screen, notifying
	the mouse's global_position the direction from this Node to the mouse.
	Useful for mouse based movement
"""

signal mouse_spotted
signal mouse_missed
signal on_spot
signal spot_changed(mouse_position, direction_to_mouse)

export(float) var on_spot_threshold = 10.0
var mouse_position = Vector2.ZERO
var direction_to_mouse = Vector2.ZERO


func _process(delta):
	if global_position.distance_to(mouse_position) <= on_spot_threshold:
		emit_signal("on_spot")


func _unhandled_input(event):
	if not event is InputEventMouse:
		return
	
	if event is InputEventMouseButton:
		handle(event)
	elif event is InputEventMouseMotion:
		update_spot()


func handle(event):
	if not event.button_index == BUTTON_LEFT:
		return
	if event.pressed:
		emit_signal("mouse_spotted")
		update_spot()
	else:
		emit_signal("mouse_missed")
	get_tree().set_input_as_handled()


func update_spot():
	mouse_position = get_global_mouse_position()
	direction_to_mouse = global_position.direction_to(mouse_position)
	emit_signal("spot_changed", mouse_position, direction_to_mouse)
