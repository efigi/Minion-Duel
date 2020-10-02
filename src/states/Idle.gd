class_name Idle
extends State

func _ready():
	state_name = "idle"
	
func interpret_inputs(input):
	if input.is_moving:
		return "moving"
	else:
		return state_name
