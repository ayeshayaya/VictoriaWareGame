
extends Node2D

@onready var themed_timer: Node2D = $ThemedTimer

var garlic_collected: int = 0
@export var garlic_required: int = 3
var timer_end: bool = false
var game_finished: bool = false


func _ready() -> void:
	$garlics/Garlic.garlic_collected.connect(garlic_collect)
	$garlics/Garlic2.garlic_collected.connect(garlic_collect)
	$garlics/Garlic3.garlic_collected.connect(garlic_collect)

	await themed_timer.Timer(10.0)

	if not game_finished and garlic_collected < garlic_required:
		timer_end = true


func _process(_delta: float) -> void:
	if game_finished:
		return

	if garlic_collected >= garlic_required:
		game_finished = true
		themed_timer.stop_timer()
		_go_to_next_screen()
		return

	if timer_end:
		game_finished = true
		Global.minigames_done -= 1
		Global.lives -= 1
		get_tree().change_scene_to_file("res://scenes/timer_screen.tscn")
		return


func garlic_collect() -> void:
	garlic_collected += 1
	print("Garlic collected: ", garlic_collected)

	if garlic_collected >= garlic_required:
		game_finished = true
		themed_timer.stop_timer()
		_go_to_next_screen()


func _go_to_next_screen() -> void:
	if Global.minigames_done > 3:
		get_tree().change_scene_to_file("res://scenes/done_screen.tscn")
	else:
		get_tree().change_scene_to_file("res://scenes/timer_screen.tscn")


func _on_area_2d_body_entered(body: Node2D) -> void:
	pass
