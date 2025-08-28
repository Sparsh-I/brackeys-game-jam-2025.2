extends Node2D

@onready var sprite = $Sprite2D

const SCALE = 2
var textures = []

func _ready():
	for i in range(0, 23):
		var path = "res://assets/sprites/value_bar/%s_value_bar.png" % i
		textures.append(load(path))
	scale_bar(SCALE)

func scale_bar(factor: int):
	sprite.scale = Vector2(factor, factor)

func set_bar_texture(value: int):
	var path: String
	if value > 21:
		sprite.texture = textures[22]
	else:
		sprite.texture = textures[value]
