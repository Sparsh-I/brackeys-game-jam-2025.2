extends Node2D

@onready var sprite = $Sprite2D

const SCALE = 2
var textures = []

func _ready():
	for i in range(0, 23):
		var path = "res://assets/sprites/value_bar/%s_value_bar.png" % i
		textures.append(load(path))
	SpriteManager.scale_sprite(sprite, SCALE)

# set the bar texture based on the value of the hand
func set_bar_texture(value: int):
	var path: String
	if value > 21:
		sprite.texture = textures[22]
	else:
		sprite.texture = textures[value]
