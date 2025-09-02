extends Biscuit

@onready var sprite = $Sprite2D

const INCREMENT = 11

func _ready():
	description = "Biscotti\n\nIncrease the bust limit by %s." % INCREMENT
	sprite.texture = preload("res://assets/sprites/biscuits/biscotti/biscotti.png")
	SpriteManager.scale_sprite(sprite, SCALE)

func apply_powerup():
	player_hand.bust_value		
	print("The biscotti has been activated!")

func deactivate_powerup():
	print("The biscotti has been deactivated!")

func _on_area_2d_mouse_entered() -> void:
	emit_signal("hovered", self)

func _on_area_2d_mouse_exited() -> void:
	emit_signal("hovered_off", self)

func set_highlighted_texture(hovered):
	if hovered:
		sprite.texture = preload("res://assets/sprites/biscuits/biscotti/biscotti_highlighted.png")
	else:
		sprite.texture = preload("res://assets/sprites/biscuits/biscotti/biscotti.png")
