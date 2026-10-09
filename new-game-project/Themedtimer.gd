
extends Node2D

@onready var timer: RichTextLabel = $timer

var time: float
var stopped: bool = false

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	timer.text = str(snapped(time, 0.10))

func Timer(start_time: float) -> void:
	time = start_time
	stopped = false

	while time > 0.0 and not stopped:
		await wait(0.10)

		if stopped:
			break

		time = maxf(0.0, time - 0.10)

func stop_timer() -> void:
	stopped = true
	time = 0.0

func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
