extends ColorRect

"""
Description:
	A ColorRect that plays an animation adding red colors to underlying
	CanvasItems
"""

onready var _animator = $AnimationPlayer

export (float) var playback_speed = 1.0

func blink():
	show()
	_animator.playback_speed = playback_speed
	_animator.play("blink")
	yield(_animator, "animation_finished")
	hide()
