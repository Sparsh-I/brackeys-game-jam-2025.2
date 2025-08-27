extends Node2D

@onready var sprite = $Sprite2D
@onready var area = $Area2D
@onready var collision = $Area2D/CollisionShape2D

const SCALE = 5

# signals for if a card is being hovered over
#signal hovered
#signal hovered_off

# constants for suits and values
const SUITS = ["hearts", "diamonds", "clubs", "spades"]
const VALUES = ["A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
var suit_name: String
var val_name: String
var face_down = false

# Set the card to the correct sprite
func set_card(suit_idx: int, val_idx: int, is_face_down: bool):
	suit_name = SUITS[suit_idx]
	val_name = VALUES[val_idx]
	self.face_down = is_face_down

# assign the correct sprite to it based on suit and value
func get_card_texture() -> Texture:
	var path: String
	if face_down:
		path = "res://assets/sprites/card_back.png"
	else:
		if suit_name and val_name:
			path = "res://assets/sprites/%s/%s_%s.png" % [suit_name, suit_name, val_name]	
		else:
			path = "res://assets/sprites/card_empty.png"
	return load(path)

func flip_over():
	face_down = false
	sprite.texture = get_card_texture()

func scale_card(factor):
	sprite.scale = Vector2(factor, factor)
	var shape = collision.shape
	shape.extents *= factor

func _ready():
	scale_card(SCALE)
	sprite.texture = get_card_texture()
	
	# all cards must be a child of CardManager
	#get_parent().connect_card_signals(self)

#func _on_area_2d_mouse_entered() -> void:
	#emit_signal("hovered", self)
#
#func _on_area_2d_mouse_exited() -> void:
	#emit_signal("hovered_off", self)
