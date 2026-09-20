extends TileMapLayer
#Script for the tile map layer

#When this node is loaded changes the tile map bounds in the level manager
func _ready() -> void:
	LevelManager.change_tile_map_bounds(_get_tile_map_bounds())

#Returns the tile map bounds as an array of 2 vectors: (position, end) * rqs
func _get_tile_map_bounds() -> Array[Vector2]:
	var bounds : Array[Vector2] = []
	
	bounds.append(Vector2(get_used_rect().position * rendering_quadrant_size))
	bounds.append(Vector2(get_used_rect().end * rendering_quadrant_size))

	return bounds
