class_name State
extends Node

export var state_name = "State"
var inputs = {
		is_moving = false,
		input_direction = Vector2.ZERO,
		is_shooting = false,
	}
	
func get_raw_input() -> Dictionary:
	inputs = {
		is_selected = owner.is_selected,#Input.is_action_pressed("move_down") or Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") or Input.is_action_pressed("move_up"),
		input_direction = get_input_direction(),
		is_shooting = Input.is_action_pressed("shoot"),
		
	}
	return inputs
	
func interpret_inputs(input):
	if input.is_selected:
		return "selected"
	else:
		return state_name

func enter():
	pass

func exit():
	pass

func get_input_direction() -> Vector2:
	return Vector2(float(Input.is_action_pressed("move_right")) - float(Input.is_action_pressed("move_left")), float(Input.is_action_pressed("move_down")) - float(Input.is_action_pressed("move_up")))

func run(_input):
	pass
