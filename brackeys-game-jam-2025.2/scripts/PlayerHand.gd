extends "res://scripts/Hand.gd"

func add_card_to_hand(card_data, pos):
	if hand_value >= 21:
		print("Bust!")
		return null
	
	var card = preload("res://scenes/card.tscn").instantiate()
	card.set_card(card_data["suit"], card_data["value"], false)

	hand.append(card)
	hand_value = calculate_hand_value()
	arrange_cards(hand, center.x, 450)
	
	print("Player: %s" % hand_value)
	if hand_value > 21:
		bust = true
		print("Bust!")
	
	return card

func _on_stand_pressed() -> void:
	pass # Replace with function body.
