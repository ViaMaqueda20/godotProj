class_name ItemEffectData extends Resource

@export_multiline var item_description : String = ""

func can_be_used() -> bool:
	return false
	
func use() -> void:
	pass
