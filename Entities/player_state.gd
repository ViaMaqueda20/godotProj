class_name PlayerState extends Node
#Defines an entity state

static var player : Player
static var player_state_machine : PlayerStateMachine


func init():
	pass

#Called when the FSM reaches this state
func enter() -> void:
	pass
	
#Called when the FSM exits this state
func exit() -> void:
	pass

#Processes the state and returns the current state
func process(_delta: float) -> PlayerState:
	return null
	
#Physic processes the current stte and returns the current state
func physics(_delta : float) -> PlayerState:
	return null

#Used when the user presses keys
func handle_input(_event : InputEvent) -> PlayerState:
	return null
