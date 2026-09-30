class_name PlayerStateMachine extends Node

var states : Array[PlayerState]
var current_state : PlayerState
var prev_state : PlayerState

#When this function called disable this node to process
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

#Processes the current state and checks if the state has changed
func _process(delta: float) -> void:
	change_state(current_state.process(delta))

#Physiscs processes the current state and checks if the state has changed
func _physics_process(delta: float) -> void:
	change_state(current_state.physics(delta))

func initialize(_player : Player) -> void:
	states = []
	
	for c in get_children():
		if c is PlayerState:
			states.append(c)
	
	if states.size()>0:
		states[0].player = _player
		states[0].player_state_machine = self
		
		for s in states:
			s.init()
			
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

#If the entity state has changed, updates the FSM.
func change_state(new_state : PlayerState) -> void:
	if new_state == null || current_state == new_state:
		return
	
	if current_state:
		current_state.exit()
	
	prev_state=current_state
	current_state=new_state
	current_state.enter()
