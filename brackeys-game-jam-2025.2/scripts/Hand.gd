extends Node

var hand_value = 0
var bust = false

var hand = []
const CARD_SPACING = 50

var screen_size: Vector2
var center: Vector2

func calculate_hand_value() -> int:
	var total = 0
	var ace_count = 0
	
	for card in hand:
		var value = card.val_name
		if value == "J" or value == "Q" or value == "K":
			total += 10;
		elif value == "A":
			total += 11
			ace_count += 1
		else:
			total += value.to_int()
	
	while total > 21 and ace_count > 0:
		total -= 10
		ace_count -= 1
	
	return total

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
	bust = false
