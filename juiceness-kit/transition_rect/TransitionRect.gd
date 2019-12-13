extends Control

"""
Description:
	A Control that plays a transition animation, blocking mouse events
	when transit in, and ignoring them when transit out
"""

signal transition_finished

onready var _animator = $AnimationPlayer

export (float) var playback_speed = 1.0

func transit_in():
	mouse_filter = Control.MOUSE_FILTER_STOP
	_animator.playback_speed = playback_speed
	var position = 0.0
	if _animator.is_playing():
		position = _animator.current_animation_position
	_animator.play("transition")
	_animator.seek(position)
	yield(_animator, "animation_finished")
	emit_signal("transition_finished")


func transit_out():
	_animator.playback_speed = playback_speed
	var position = 1.0
	if _animator.is_playing():
		position = _animator.current_animation_position
	_animator.play_backwards("transition")
	_animator.seek(position)
	yield(_animator, "animation_finished")
	emit_signal("transition_finished")
	mouse_filter = Control.MOUSE_FILTER_IGNORE
