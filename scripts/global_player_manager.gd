extends Node

## Global singleton for managing the player instance across scenes.
## This autoload script creates and maintains a persistent player reference
## that can be accessed from anywhere in the game.

## Emitted when the player presses the interaction key/button.
## Other systems can connect to this signal to handle interaction events.
signal interaction_pressed()


## Preloaded player scene for instantiation
const PLAYER = preload("res://scenes/player.tscn")


## Reference to the current player instance
var player : Player


## Tracks whether the player has been spawned in the game worlda
var player_spawned : bool


## Called when the node enters the scene tree for the first time.
## Initializes the player_spawned flag and creates the player instance.
func _ready() -> void:
	player_spawned = false
	_create_player_instance()


## Sets the player's global position in the world.
##
## Parameters:
## - _new_position: The new Vector2 position where the player should be placed
func set_player_position(_new_position : Vector2) -> void:
	player.global_position = _new_position


## Reparents the player to a new parent node.
## If the player already has a parent, it removes the player from that parent
## before adding it to the new one.
##
## Parameters:
## - _parent: The new parent node to attach the player to
func set_player_parent(_parent : Node) -> void:
	# Check if player has an existing parent and remove it
	if player.get_parent():
		player.get_parent().remove_child(player)
	# Add player to the new parent
	_parent.add_child(player)


## Removes the player from the specified parent node.
##
## Parameters:
## - _parent: The parent node to remove the player from
func remove_player_parent(_parent : Node) -> void:
	_parent.remove_child(player)


## Internal function to create the player instance.
## Instantiates the PLAYER scene and adds it as a child of this manager.
## This keeps the player persistent across scene changes since this is an autoload.
func _create_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child(player)
