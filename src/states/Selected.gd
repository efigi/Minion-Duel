class_name Selected
extends State

func _ready():
	state_name = "selected"

func enter():
	owner.play_audio(state_name)
	get_tree().call_group("selectors","change_visible", true)
	#orrrrrr
	#1. calculate move and attack range
	calculate_range_positions()
	#2. mark move and attack squares
	#3. change squares in selector
	#4. get_tree().call_group("selectors","change_visible", true)
	
	owner.select_box.visible = true

func exit():
	get_tree().call_group("selectors","change_visible", false)
	owner.select_box.visible = false

func calculate_range_positions():
	pass
	#1. calculate move range
	#2. calculate attack range
