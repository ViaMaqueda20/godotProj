@tool
class_name ItemPickup extends CharacterBody2D


@export var item_data : ItemData : set = _set_item_data
@export var pickable : bool = true
@export_range(0,2) var pick_delay : float = 0.6

@export_category("Drop Physics")
@export var deceleration : float = 6.0
@export_range(0,90) var velocity_gamma : float = 80
@export var min_drop_speed : float = 1.0
@export var max_drop_speed : float = 1.5


@onready var sprite: Sprite2D = $Sprite2D
@onready var area: Area2D = $Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


func _ready() -> void:
	_update_texture()
	if Engine.is_editor_hint():
		return
	area.body_entered.connect(_body_entered)
	area.monitoring = false	
	await get_tree().create_timer(pick_delay).timeout
	area.monitoring = true
	
	
func _physics_process(delta: float) -> void:
	var collision_info = move_and_collide(velocity * delta)
	if collision_info:
		velocity = velocity.bounce(collision_info.get_normal())
	velocity -= velocity * delta * deceleration


func set_drop_velocity(source_velocity : Vector2) -> void:
	velocity = source_velocity.rotated(randf_range(deg_to_rad(-velocity_gamma),\
	deg_to_rad(velocity_gamma)))* randf_range(min_drop_speed,max_drop_speed)


func _body_entered(_body : Node2D) -> void:
	if _body is Player:
		if item_data and pickable:
			if PlayerManager.PLAYER_INVENTORY_DATA.add_item(item_data):
				pick_up_item()


func pick_up_item() -> void:
	area.body_entered.disconnect(_body_entered)
	queue_free()


func _set_item_data(value : ItemData) -> void:
	item_data = value
	_update_texture()


func _update_texture() -> void:
	if item_data and sprite:
		sprite.texture = item_data.texture
