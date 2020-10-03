class_name Selector
extends TileMap


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var anim = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	change_visible(false)
	anim.playback_speed = 1.5

func change_visible(val := true):
	visible = val
	if val:
		anim.play("idle")
	else:
		anim.stop()
