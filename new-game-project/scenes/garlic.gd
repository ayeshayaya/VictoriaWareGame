
extends Node2D

@onready var player_area: Area2D = get_node("../../Player/Area2D")
@onready var self_area: Area2D = $Area2D

signal garlic_collected

var collected: bool = false

func _process(_delta: float) -> void:
	if collected:
		return

	if player_area.overlaps_area(self_area):
		collected = true
		garlic_collected.emit()
		hide()
