class_name Player extends CharacterBody2D

signal direction_changed()

const DIR_VEC = [Vector2.RIGHT,Vector2.DOWN,Vector2.LEFT,Vector2.UP]

var direction : Vector2
var cardinal_direction : Vector2
var speed : float = 100.0
var hp := 9
var max_hp := 9

@onready var sprite : Sprite2D = $Sprite2D
@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var player_state_machine : PlayerStateMachine = $PlayerStateMachine

func _ready() -> void:
	direction = Vector2.ZERO
	cardinal_direction = Vector2.DOWN
	
	PlayerManager.player = self
	PlayerHud.update_hp(hp,max_hp)
	player_state_machine.initialize(self)
	
func _process(delta: float) -> void:
	direction = Vector2(
		Input.get_axis("key_left","key_right"),
		Input.get_axis("key_up","key_down")
	)
	
func _physics_process(delta: float) -> void:
	move_and_slide()

func set_card_direction() -> bool:
	if direction == Vector2.ZERO:
		return false
	
	var new_cardinal_direction : Vector2 = DIR_VEC[int(round((direction+cardinal_direction*0.1).angle()/TAU*DIR_VEC.size()))] 

	if cardinal_direction == new_cardinal_direction:
		return false
	
	direction_changed.emit(new_cardinal_direction)
	
	sprite.scale.x = -1 if direction.x<0 else 1
	cardinal_direction=new_cardinal_direction
	
	return true
	
func update_animation(state : String) -> void:
	animation_player.play(state + "_" + _vector_to_direction())

func _vector_to_direction() -> String:
	if cardinal_direction==Vector2.DOWN:
		return "down"
	elif cardinal_direction==Vector2.UP: 
		return "up"
	else:
		return "side"
