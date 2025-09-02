extends Biscuit

@onready var sprite = $Sprite2D

var player_hand = null
const PROB = 0.6

func _ready():
	description = "Only the first and last cards count towards the score"
	sprite.texture = preload("res://assets/sprites/biscuits/sando/sando.png")
	SpriteManager.scale_sprite(sprite, 10)

func apply_powerup():
	var count = 1
	var max = player_hand.hand.size()
	for card in player_hand.hand:
		if count != 1 and count != max:
			card.deactivate()
		count += 1
		
	print("The sando has been activated!")

func deactivate_powerup():
	print("The sando has been deactivated!")

func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovered", self)

func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovered_off", self)

func set_highlighted_texture(hovered):
	if hovered:
		sprite.texture = preload("res://assets/sprites/biscuits/sando/sando_highlighted.png")
	else:
		sprite.texture = preload("res://assets/sprites/biscuits/sando/sando.png")
