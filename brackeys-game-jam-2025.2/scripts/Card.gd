extends Node2D

@onready var sprite = $Sprite2D
@onready var area = $Area2D
@onready var collision = $Area2D/CollisionShape2D

# signals for if a card is being hovered over
#signal hovered
#signal hovered_off

# constants for suits and values
const SUITS = ["hearts", "diamonds", "clubs", "spades"]
const VALUES = ["A", "02", "03", "04", "05", "06", "07", "08", "09", "10", "J", "Q", "K"]
var suit_name: String
var val_name: String
var face_down = false

# Set the card to the correct sprite
func set_card(suit_idx: int, val_idx: int, is_face_down: bool):
	suit_name = SUITS[suit_idx]
	val_name = VALUES[val_idx]
	self.face_down = is_face_down
	
	if face_down:
		sprite.texture = preload("res://assets/sprites/card_back.png")
	else:
		sprite.texture = get_card_texture(suit_name, val_name)


# assign the correct sprite to it based on suit and value
func get_card_texture(suit_name: String, val_name: String) -> Texture:
	var path: String
	if suit_name and val_name:
		path = "res://assets/sprites/%s/card_%s_%s.png" % [suit_name, suit_name, val_name]	
	else:
		path = "res://assets/sprites/card_empty.png"
	return load(path)

func flip_over():
	face_down = false
	sprite.texture = get_card_texture(suit_name, val_name)

func scale_card(factor):
	sprite.scale = Vector2(factor, factor)
	
	var shape = collision.shape
	shape.extents *= factor

func _ready():
	# all cards must be a child of CardManager
	#get_parent().connect_card_signals(self)

	scale_card(3)

#func _on_area_2d_mouse_entered() -> void:
	#emit_signal("hovered", self)
#
#func _on_area_2d_mouse_exited() -> void:
	#emit_signal("hovered_off", self)
