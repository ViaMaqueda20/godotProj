extends CanvasLayer

signal shown()
signal hidden()

@onready var resume_button : Button = $Control/Button
@onready var item_description_label: Label = $Control/ItemDescriptionLabel

var is_paused : bool

func _ready() -> void:
	LevelManager.level_load_started.connect(hide_pause_menu)
	resume_button.pressed.connect(hide_pause_menu)
	hide_pause_menu()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("key_esc") and LevelManager.is_pausable:
		if is_paused:
			hide_pause_menu()
		else:
			show_pause_menu()
	get_viewport().set_input_as_handled()

func show_pause_menu() -> void:
	is_paused = true
	visible = true
	get_tree().paused = true
	shown.emit()
	
func hide_pause_menu() -> void:
	is_paused = false
	visible = false
	get_tree().paused = false
	hidden.emit()
	
func update_item_description(text : String) -> void:
	item_description_label.text = text
