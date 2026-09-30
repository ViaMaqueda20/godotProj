extends Node

#Called when a new level has loaded
signal level_loaded()

#Called when a level is starting to load
signal level_load_started()

#Called when the map bounds changed
signal tile_map_bounds_changed(bounds : Array[Vector2])

#The current tile map bounds
var tile_map_bounds : Array[Vector2]
var target_transition : String
var is_pausable : bool

#When it starts emits level_loaded signal as default after a process frame
func _ready() -> void:
	await get_tree().process_frame
	level_loaded.emit()
	is_pausable = true
	
func load_new_level(_level_path : String, _target_transition : String) -> void:
	
	target_transition = _target_transition
	get_tree().paused = true
	is_pausable = false
	
	await SceneTransition.fade_in()

	level_load_started.emit()
	
	await get_tree().process_frame
	
	get_tree().change_scene_to_file(_level_path)
	
	await get_tree().process_frame
	
	get_tree().paused = false
	
	await SceneTransition.fade_out()
	
	level_loaded.emit()
	is_pausable = true
	
#Changes the tile map bounds
func change_tile_map_bounds(_bounds : Array[Vector2]) -> void:
	tile_map_bounds = _bounds
	tile_map_bounds_changed.emit(tile_map_bounds)
