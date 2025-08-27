extends "res://scripts/Hand.gd"

const STAND_VALUE: int = 17

func add_card_to_hand(card_data, pos):
	if hand_value >= STAND_VALUE:
		print("Dealer stands!")
		return null
	
	if hand.size() <= 3:
		var card = preload("res://scenes/card.tscn").instantiate()
		card.set_card(card_data["suit"], card_data["value"], hand.size() >= 1)
		
		hand.append(card)	
		hand_value = calculate_hand_value()
		arrange_cards(hand, center.x, 150)
		
		print("Dealer: %s" % hand_value)
		if hand_value >= STAND_VALUE:
			if hand_value > 21:
				bust = true
			print("Dealer stands!")
		
		return card
