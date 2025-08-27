extends "res://scripts/Hand.gd"

const STAND_VALUE: int = 17

func add_card_to_hand(card_data, pos):
	if hand_value >= STAND_VALUE:
		print("Dealer stands!")
		return null
	
	if card_count <= 3:
		var card = preload("res://scenes/card.tscn").instantiate()
		card.call_deferred("set_card", card_data["suit"], card_data["value"], card_count >= 1)
		
		hand_value += get_value(card_data["value"])
		print("Dealer: %s" % hand_value)
		if hand_value >= STAND_VALUE:
			print("Dealer stands!")
		
		card.position = Vector2(pos.x + card_count * 50, pos.y)
		card_count += 1
		hand.append(card)
		arrange_cards(hand, center.x, 150)

		return card
