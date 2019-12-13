extends CanvasModulate

"""
Description:
	A CanvasModulate that plays an animation painting all CanvasItems
	with a red color
"""

onready var _animator = $AnimationPlayer

export (float) var playback_speed = 1.0

func blink():
	show()
	_animator.playback_speed = playback_speed
	_animator.play("blink")
	yield(_animator, "animation_finished")
	hide()
