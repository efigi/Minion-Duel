class_name Character
extends Node2D


export (String, "left", "right") var team = "left"

var map_position := Vector2.ZERO
var world_position := Vector2.ZERO
 
onready var sprite = $Sprite

func _ready():
	if team == "right":
		sprite.flip_h = true
	print(team)
