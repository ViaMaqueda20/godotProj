class_name ItemData extends Resource

@export var name : String
@export_multiline var description : String
@export var texture : Texture2D
@export var item_effects : Array[ItemEffectData]

func use() -> bool:
	if item_effects.size() > 0:
		for effect in item_effects:
			if effect:
				if !effect.can_be_used():
					return false
		for effect in item_effects:
			if effect:
				if effect.can_be_used():
					effect.use()
		return true
	return false
		
