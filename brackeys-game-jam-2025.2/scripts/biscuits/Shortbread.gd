extends Biscuit

@onready var sprite = $Sprite2D

var player_hand = null
const PROB = 0.6

func _ready():
	description = "Halve the score in your hand."
	sprite.texture = preload("res://assets/sprites/biscuits/shortbread/shortbread.png")
	SpriteManager.scale_sprite(sprite, 10)

func apply_powerup():
	player_hand.hand_value /= 2		
	print("The shortbread has been activated!")

func deactivate_powerup():
	print("The shortbread has been deactivated!")

func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovered", self)

func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovered_off", self)

func set_highlighted_texture(hovered):
	if hovered:
		sprite.texture = preload("res://assets/sprites/biscuits/shortbread/shortbread_highlighted.png")
	else:
		sprite.texture = preload("res://assets/sprites/biscuits/shortbread/shortbread.png")
