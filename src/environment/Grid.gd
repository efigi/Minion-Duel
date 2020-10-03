class_name Grid
extends TileMap

onready var player_resource = preload("res://src/characters/Player.tscn")
onready var enemy_resource = preload("res://src/characters/Enemy.tscn")
onready var allies_holder = get_parent().get_parent().get_parent().get_node("Characters/Allies")
onready var enemies_holder = get_parent().get_parent().get_parent().get_node("Characters/Enemies")

var cells : Dictionary = {
	Vector2(2,4) : "player",
	Vector2(8,5) : "enemy",
	Vector2(12,4) : "enemy",	
	Vector2(10,3) : "enemy",
	
	#LIMITS ARE 2,2 and 12,6!
}

func _ready():
	var character
	for cell in cells.keys():
		match cells[cell]:
				"player": #player
					character = player_resource.instance()
					character.position = cell * Vector2 (128,88) * Vector2(0.5, 0.7) + Vector2(32, 0)# + Vector2(32, (-88*1.05))
					allies_holder.add_child(character)
					yield(get_tree().create_timer(0.1), "timeout")
				"enemy": #enemy
					character = enemy_resource.instance()
					character.position = cell * Vector2 (128,88) * Vector2(0.5, 0.7) + Vector2(32, 0)# + Vector2(32, (-88*1.05))
					enemies_holder.add_child(character)
		character.setup(cell)
		yield(get_tree().create_timer(0.3), "timeout")
		
