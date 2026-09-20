extends CanvasLayer


var hearts : Array[HeartGUI]


func _ready() -> void:
	for c in $Control/LifeGui/HFlowContainer.get_children():
		if c is HeartGUI:
			hearts.append(c)
			c.visible = false


func update_hp(_hp : int, _max_hp : int) -> void:
	update_max_hp(_max_hp)
	for i in _max_hp:
		update_heart(i,_hp)


func update_heart(_index : int, _hp : int) -> void:
	hearts[_index].value = clampi(_hp-_index*2,0,2)


func update_max_hp(_max_hp : int) -> void:
	for i in ceil(_max_hp*0.5):
		hearts[i].visible = true
