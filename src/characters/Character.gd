class_name Character
extends KinematicBody2D


export (String, "left", "right") var team = "left"

var map_position := Vector2.ZERO
var world_position := Vector2.ZERO
var is_selected := false

onready var sprite = $Sprite

var _state = null
var possible_states : Dictionary = {}
onready var states_holder = $States

func _ready():
	if states_holder != null:
		for child in states_holder.get_children():
			possible_states[child.state_name] = child #grabs first state, which is usually idle
			if _state == null:
				_state = child
	print(_state.state_name)
	if team == "right":
		sprite.flip_h = true
	print(team)

func _physics_process(delta):
	var input = _state.get_raw_input()
	change_state(_state.interpret_inputs(input))
	_state.run(input)

func change_state(state_name, repeat = false):
	var new_state = possible_states[state_name]
	if _state != new_state or repeat:
		print("STATE IS ", state_name)
		exit_state()
		_state = new_state
		enter_state()
	
func enter_state():
	_state.enter()
	
func exit_state():
	_state.exit()

func change_direction(dir):
	pass

func _on_Character_input_event(_viewport, event, _shape_idx): #ie if character was clicked!
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and _state.state_name == "idle":
			change_state("idle")
			is_selected = true
			get_tree().call_group("selectors","change_visible")

func _unhandled_input(event): #if clicked anywhere, whether in character or not
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and _state.state_name != "idle":
			change_state("idle")
			is_selected = false
			get_tree().call_group("selectors","change_visible")

#func _input_event(_viewport, event, _shape_idx):
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT and event.pressed:
#			get_tree().call_group("selectors","change_visible")
