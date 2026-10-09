
extends Node2D

@onready var themed_timer = $Themedtimer

var buttons_pressed: int = 0
var game_finished: bool = false


func _ready() -> void:
	buttons_pressed = 0
	game_finished = false
	run_timer()


func run_timer() -> void:
	await themed_timer.Timer(7.0)

	if not game_finished:
		game_finished = true
		Global.lives -= 1
		Global.minigames_done -= 1
		get_tree().change_scene_to_file("res://scenes/timer_screen.tscn")


func _on_button_1_pressed() -> void:
	button_pressed($Button_1)


func _on_button_2_pressed() -> void:
	button_pressed($Button_2)


func _on_button_3_pressed() -> void:
	button_pressed($Button_3)


func _on_button_4_pressed() -> void:
	button_pressed($Button_4)


func button_pressed(button: TextureButton) -> void:
	if game_finished or not button.visible:
		return

	button.hide()
	buttons_pressed += 1
	print("Buttons pressed: ", buttons_pressed)

	if buttons_pressed >= 4:
		game_finished = true

		if themed_timer.has_method("stop_timer"):
			themed_timer.stop_timer()

		if Global.minigames_done > 1:
			get_tree().change_scene_to_file("res://scenes/done_screen.tscn")
		else:
			get_tree().change_scene_to_file("res://scenes/timer_screen.tscn")
