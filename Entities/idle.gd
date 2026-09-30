extends PlayerState
#Idle: the player is still

@export var _animation_name := "idle" 

#These are references to other useful states
@onready var walk : PlayerState = $"../Walk"


func enter() -> void:
	player.update_animation(_animation_name)

#Checks wether the player is idle. If the direction isn't the null vector changes the state
func process(_delta: float) -> PlayerState:
	if player.direction != Vector2.ZERO:
		return walk
	player.velocity = Vector2.ZERO
	return null

#Checks wether the player is pressing any keys. If the player is pressing the attack key changes the state
func handle_input(_event : InputEvent) -> PlayerState:
	if(_event.is_action_pressed("key_interact")):
		PlayerManager.interaction_pressed.emit()
	return null
