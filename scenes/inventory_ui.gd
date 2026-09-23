class_name InventoryUI extends Control

const INVENTORY_SLOT_UI = preload("res://scenes/inventory_solt_ui.tscn")

var focus_index : int = 0

@export var inventory_data : InventoryData

func _ready() -> void:
	PauseMenu.shown.connect(update_inventory)
	PauseMenu.hidden.connect(clear_inventory)
	inventory_data.changed.connect(inventory_changed)

func clear_inventory() -> void:
	for c in get_children():
		c.queue_free()
	
func update_inventory() -> void:
	for s in inventory_data.slots:
		var slot : InventorySlotUI = INVENTORY_SLOT_UI.instantiate()
		add_child(slot)
		slot.slot_data = s
	
	await get_tree().process_frame
	get_child(focus_index).grab_focus()
	focus_index = 0


func set_focus_index() -> void:
	focus_index = 0
	for i in get_child_count():
		if get_child(i) is InventorySlotUI:
			if get_child(i).has_focus():
				break
			focus_index += 1


func inventory_changed() -> void:
	set_focus_index()
	clear_inventory()
	update_inventory()
