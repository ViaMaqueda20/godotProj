class_name InventorySlotUI extends Button

var slot_data : SlotData : set = set_slot_data

@onready var texture_rect: TextureRect = $TextureRect
@onready var label: Label = $Label

func _ready() -> void:
	texture_rect.texture = null
	label.text = ""
	
	focus_entered.connect(_focused)
	focus_exited.connect(_unfocused)
	#pressed.connect(item_pressed)


func set_slot_data(data : SlotData) -> void:
	slot_data = data
	if slot_data != null and slot_data.item_data != null:
		texture_rect.texture = slot_data.item_data.texture
		label.text = str(slot_data.quantity)


func _focused() -> void:
	if slot_data != null and slot_data.item_data != null:
		PauseMenu.update_item_description(slot_data.item_data.description)


func _unfocused() -> void:
	PauseMenu.update_item_description("")
	
#func item_pressed() -> void:
	#if slot_data != null and slot_data.item_data != null:
		#if slot_data.item_data.use():
			#slot_data.quantity -= 1
			#label.text = str(slot_data.quantity)
