extends Node

var card_count: int = 0
var hand_value: int = 0

var hand: Array = []
const CARD_SPACING: int = 50

var screen_size: Vector2
var center: Vector2

func get_value(value) -> int:
	if value == 10 or value == 11 or value == 12:
		return 10;
	elif value == 0:
		if hand_value + 11 <= 21:
			return 11
	return value+1

func arrange_cards(cards: Array, center_x: float, y_val: float, spacing: int = CARD_SPACING):
	var count = hand.size()
	if count == 0:
		return
	
	var total_width = (count - 1) * spacing
	var start_x = center_x - total_width / 2
	
	for i in range(count):
		hand[i].position = Vector2(start_x + i * spacing, y_val)

func _ready():
	var screen_size = get_viewport().get_visible_rect().size
	center = screen_size / 2
