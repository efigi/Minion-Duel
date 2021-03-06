class_name Character
extends KinematicBody2D

export (String, "left", "right") var team := "left"
export (int) var attack_range := 1
export (int) var move_range := 1


var map_pos := Vector2.ZERO setget set_map_pos
var is_selected := false

onready var pivot = $Pivot
onready var sprite = $Pivot/Sprite
onready var state_label = $UI/State
onready var select_box = $UI/SelectBox

var _state = null
var possible_states : Dictionary = {}
onready var states_holder = $States
onready var tween =$Addons/Tween
	
func _ready():
	position += (Vector2.UP * 400)
	if states_holder != null:
		for child in states_holder.get_children():
			possible_states[child.state_name] = child #grabs first state, which is usually idle
			if _state == null:
				_state = child
				state_label.text = _state	.state_name
	if team == "right":
		for child in pivot.get_children():
			child.scale.x *= -1
	tween.interpolate_property(self, "position",position, position + (Vector2.DOWN * 400), 0.7, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	tween.start()
	
func _physics_process(_delta):
	var input = _state.get_raw_input()
	change_state(_state.interpret_inputs(input))
	_state.run(input)

func change_state(state_name, repeat = false):
	var new_state = possible_states[state_name]
	if _state != new_state or repeat:
		_state.exit()
		_state = new_state
		state_label.text = _state	.state_name
		_state.enter()

func change_direction(_dir):
	pass

func _on_Character_input_event(_viewport, event, _shape_idx): #ie if character was clicked!
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and _state.state_name == "idle":
			print("ON IT")		
			is_selected = true

func _input(event): #if clicked anywhere, whether in character or not
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed and _state.state_name != "idle":
			print("IMHERE")		
			is_selected = false

func play_audio(audio : String):
	match audio:
		"selected":
			$Audio/Selected.play()
		"land":
			$Audio/Move.play()
#func _input_event(_viewport, event, _shape_idx):
#	if event is InputEventMouseButton:
#		if event.button_index == BUTTON_LEFT and event.pressed:
#			get_tree().call_group("selectors","change_visible")

func set_map_pos(pos):
	map_pos = pos
	position = map_pos * Vector2 (128,88) * Vector2(0.5, 0.7) + Vector2(32, 0)
	
func _on_Tween_tween_completed(_object, key):
	if key == ":position":
		$Addons/AnimationPlayer.play("idle")
		play_audio("land")
		print("team ", team, " at ", global_position)
