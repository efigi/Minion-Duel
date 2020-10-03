class_name Selected
extends State

func _ready():
	state_name = "selected"

func enter():
	owner.play_audio(state_name)
	get_tree().call_group("selectors","change_visible")
	owner.select_box.visible = true

func exit():
	get_tree().call_group("selectors","change_visible")
	owner.select_box.visible = false
