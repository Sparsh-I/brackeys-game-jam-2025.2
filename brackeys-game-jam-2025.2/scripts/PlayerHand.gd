extends "res://scripts/Hand.gd"

func add_card_to_hand(card_data, pos):
	if hand_value >= 21:
		print("Bust!")
		return null
	
	var card = preload("res://scenes/card.tscn").instantiate()
	card.call_deferred("set_card", card_data["suit"], card_data["value"], false)
	
	hand_value += get_value(card_data["value"])
	print("Player: %s" % hand_value)
	if hand_value >= 21:
		print("Bust!")
	
	card.position = Vector2(pos.x + card_count * 50, pos.y)
	card_count += 1
	hand.append(card)
	arrange_cards(hand, center.x, screen_size.y + 450)
	return card

func _on_stand_pressed() -> void:
	pass # Replace with function body.
