class_name Level
extends Node2D

var menu_path = ""

onready var selector = $Background/Layer2/Selector

func _ready():
	pass

func _unhandled_input(event):
	if event.is_action_pressed("reset"):
		var _error = get_tree().reload_current_scene()
	elif event.is_action_pressed("menu"):
		var _error = get_tree().change_scene(menu_path)
	elif event.is_action_pressed("debug"):
		selector.visible = not selector.visible
