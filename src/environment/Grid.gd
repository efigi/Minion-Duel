class_name Grid
extends TileMap

onready var player_resource = preload("res://src/characters/Player.tscn")
onready var enemy_resource = preload("res://src/characters/Enemy.tscn")
onready var minion_resource = preload("res://src/characters/Minion.tscn")
onready var follower_resource = preload("res://src/characters/Follower.tscn")
onready var allies_holder = get_parent().get_parent().get_parent().get_node("Characters/Allies")
onready var enemies_holder = get_parent().get_parent().get_parent().get_node("Characters/Enemies")

var map_offset = Vector2(1,1)

var allies_cells : Dictionary = {
	Vector2(4,5) : "follower",
	Vector2(2,4) : "follower",
	Vector2(1,3) : "player",
	Vector2(3,2) : "follower",
}

var enemies_cells : Dictionary = {
	Vector2(8,5) : "minion",
	Vector2(7,4) : "minion",
	Vector2(11,3) : "enemy",		
	Vector2(9,2) : "minion",
}

func _ready():
	for cell in allies_cells.keys():
		spawn_character(cell, allies_cells[cell])
		yield(get_tree().create_timer(0.3), "timeout")
	
	yield(get_tree().create_timer(0.3), "timeout")
	
	for cell in enemies_cells.keys():
		spawn_character(cell, enemies_cells[cell])
		yield(get_tree().create_timer(0.3), "timeout")
		
func spawn_character(map_pos, type):
	map_pos += map_offset
	print(map_pos)
	var character
	match type:
		"player": #player
			character = player_resource.instance()
			character.set_map_pos(map_pos)# + Vector2(32, (-88*1.05))
			allies_holder.add_child(character)
		"enemy": #enemy
			character = enemy_resource.instance()
			character.set_map_pos(map_pos)# + Vector2(32, (-88*1.05))			
			enemies_holder.add_child(character)
		"minion":
			character = minion_resource.instance()
			character.set_map_pos(map_pos)# + Vector2(32, (-88*1.05))			
			enemies_holder.add_child(character)
		"follower":
			character = follower_resource.instance()
			character.set_map_pos(map_pos)# + Vector2(32, (-88*1.05))			
			allies_holder.add_child(character)
#	character.setup(map_pos) #store valye inside
