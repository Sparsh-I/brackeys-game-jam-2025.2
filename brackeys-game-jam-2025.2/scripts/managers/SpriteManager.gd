extends Node

# scale the given sprite by the provided factor
func scale_sprite(sprite: Sprite2D, factor: int):
	sprite.scale = Vector2(factor, factor)
