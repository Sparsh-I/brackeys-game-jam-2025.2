extends Biscuit

@onready var sprite = $Sprite2D

const PROB = 0.6

func _ready():
	description = "Cookie\n\nOnly a random selection of card(s) currently in hand go towards the hand value."
	sprite.texture = preload("res://assets/sprites/biscuits/cookie/cookie.png")
	SpriteManager.scale_sprite(sprite, SCALE)

func apply_powerup():
	for card in player_hand.hand:
		if randf() < PROB:
			card.deactivate()

func deactivate_powerup():
	print("The cookie has been deactivated!")

func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovered", self)

func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovered_off", self)

func set_highlighted_texture(hovered):
	if hovered:
		sprite.texture = preload("res://assets/sprites/biscuits/cookie/cookie_highlighted.png")
	else:
		sprite.texture = preload("res://assets/sprites/biscuits/cookie/cookie.png")
