extends PlayerState
#Walk: the player is walking and the user is pressing arrow keys

@export var _animation_name := "walk"
@export var _speed : float = 100.0

#references to other states
@onready var idle : PlayerState = $"../Idle"


func enter() -> void:
	player.update_animation(_animation_name)

#Returns idle if the user stops pressing arrow keys. Sets the player velocity and updates the cardinal direction
func process(_delta: float) -> PlayerState:
	if player.direction == Vector2.ZERO:
		return idle
		
	player.velocity = player.direction * _speed
	
	if player.set_card_direction():
		player.update_animation(_animation_name)
	return null

#Checks wether the player is attacking or interacting
func handle_input(_event : InputEvent) -> PlayerState:
	if(_event.is_action_pressed("key_interact")):
		PlayerManager.interaction_pressed.emit()
	return null
