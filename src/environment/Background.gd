extends ParallaxBackground


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _process(delta):
	$Layer1.motion_offset.x += 0.15
#	$Layer1.motion_offset.x += 0.3
	$Layer3.motion_offset.x += 0.5
