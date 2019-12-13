extends Camera2D

"""
Description:
	A Camera2D with the ability to shake the screen and vibrate player's
	controllers.
"""

signal shake_started
signal shake_finished

export (Vector2) var shake_strength = Vector2(10, 10)
export (float) var duration = 1.0

export (int) var joystick_index = 0
export (float, 0.0, 1.0) var vibration_strength_weak_motor = 0.5
export (float, 0.0, 1.0) var vibration_strength_strong_motor = 0.5

onready var _duration_timer = $Duration

func _ready():
	joystick_index = max(0, joystick_index)
	_duration_timer.connect("timeout", self, "stop")
	set_process(false)


func _process(delta):
	offset.x = rand_range(-shake_strength.x, shake_strength.x)
	offset.y = rand_range(-shake_strength.y, shake_strength.y)


func shake():
	_duration_timer.start(duration)
	vibrate()
	set_process(true)
	emit_signal("shake_started")


func stop():
	if not _duration_timer.is_stopped():
		_duration_timer.stop()
	offset = Vector2.ZERO
	Input.stop_joy_vibration(joystick_index)
	set_process(false)
	emit_signal("shake_finished")


func vibrate():
	Input.start_joy_vibration(joystick_index, vibration_strength_weak_motor,
			vibration_strength_strong_motor)
