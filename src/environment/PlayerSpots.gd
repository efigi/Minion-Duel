class_name PlayerSpots
extends TileMap

onready var grid = get_parent().get_node("Grid")
onready var player_resource = preload("res://src/characters/Player.tscn")
onready var enemy_resource = preload("res://src/characters/Enemy.tscn")
onready var allies_holder = get_parent().get_parent().get_parent().get_node("Characters/Allies")
onready var enemies_holder = get_parent().get_parent().get_parent().get_node("Characters/Enemies")

func _ready():
	for cell in get_used_cells():
		var cell_world_pos = map_to_world(cell)
		var cell_index = get_cell(cell.x, cell.y)
		print(cell_world_pos)
		
		var grid_map_pos = grid.world_to_map(cell_world_pos)
		var character
		match cell_index:
			2: #player
				character = player_resource.instance()
				character.global_position = grid.map_to_world(grid_map_pos) - (Vector2.ONE * 100)
				allies_holder.add_child(character)
			1: #enemy
				character = enemy_resource.instance()
				character.global_position = grid.map_to_world(grid_map_pos) - (Vector2.ONE * 100)
				enemies_holder.add_child(character)
	visible = false
