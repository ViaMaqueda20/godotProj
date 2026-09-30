class_name HeartGUI extends Control

@onready var sprite : Sprite2D = $Sprite2D

var value : int = 2 :
	set(_v):
		value=_v
		sprite.frame = value
