class_name PlayerSpots
extends TileMap

onready var grid = get_parent().get_node("Grid")

func _ready():
	for cell in get_used_cells():
		var cell_world_pos : = map_to_world(cell) * Vector2(0.5, 1)
		var cell_index = get_cell(cell.x, cell.y)
		
		var grid_map_pos = grid.world_to_map(cell_world_pos + Vector2(32,64))
		print("index ", cell_index, " at map_pos ", cell, " at world_pos ", cell_world_pos, " and grid_map at ", grid_map_pos)
		var character
		match cell_index:
			2: #player
				character = player_resource.instance()
				character.position = cell_world_pos + Vector2(32, (-88*1.05))
				allies_holder.add_child(character)
			1: #enemy
				character = enemy_resource.instance()
				character.position = cell_world_pos + Vector2(32, -88*1.05)
				enemies_holder.add_child(character)
	visible = false
