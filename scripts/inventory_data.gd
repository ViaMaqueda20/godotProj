class_name InventoryData extends Resource


@export var slots : Array[SlotData]

func _init() -> void:
	connect_slots()


func add_item(item_data : ItemData, count : int = 1) -> bool:
	for s in slots:
		if s != null and s.item_data != null:
			if s.item_data == item_data:
				s.quantity += count
				return true
				
	for i in slots.size():
		if slots[i] == null:
			var new_slot := SlotData.new()
			new_slot.item_data = item_data
			new_slot.quantity = count
			slots[i] = new_slot
			slots[i].changed.connect(slot_changed)
			return true
			
	return false


func connect_slots() -> void:
	for s in slots:
		if s != null and s.item_data != null:
			s.changed.connect(slot_changed)


func slot_changed() -> void:
	for i in slots.size():
		if slots[i] != null:
			if slots[i].quantity <= 0:
				slots[i].changed.disconnect(slot_changed)
				slots[i] = null
				emit_changed()


func inventory_to_save() -> Array[Dictionary]:
	var result : Array[Dictionary] = []
	for i in slots.size():
		result.append(slot_data_to_dictionary(slots[i]))
	return result


func slot_data_to_dictionary(slot_data : SlotData) -> Dictionary:
	var result := {item_data = "", quantity = 0}
	if slot_data != null:
		result.quantity = slot_data.quantity
		if slot_data.item_data != null:
			result.item_data = slot_data.item_data.resource_path
	return result


func parse_inventory_data(_slots : Array)-> void:
	slots.clear()
	slots.resize(_slots.size())
	for i in slots.size():
		slots[i] = dictionary_to_slot_data(_slots[i])
	connect_slots()


func dictionary_to_slot_data(dict : Dictionary) -> SlotData:
	if dict.item_data == "":
		return null
	var slot_data := SlotData.new()
	slot_data.item_data = load(dict.item_data)
	slot_data.quantity = dict.quantity
	return slot_data
