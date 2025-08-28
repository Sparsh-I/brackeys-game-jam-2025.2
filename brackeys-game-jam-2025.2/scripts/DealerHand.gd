extends "res://scripts/Hand.gd"

@onready var score = $"../UI/DealerScore"

const STAND_VALUE = 17

func add_card_to_hand(card_data):
	if hand_value >= STAND_VALUE:
		print("Dealer stands!")
		return null
	
	if hand.size() <= 3:
		var card = preload("res://scenes/card.tscn").instantiate()
		card.set_card(card_data["suit"], card_data["value"], hand.size() >= 1)
		
		hand.append(card)	
		hand_value = calculate_hand_value()
		arrange_cards(hand, center.x, 150)
		
		score.text = "Dealer: %s" % hand_value
		if hand_value >= STAND_VALUE:
			if hand_value > 21:
				bust = true
			print("Dealer stands!")
		
		return card

func calculate_visible_hand_value():
	var total = 0
	if hand.size() == 0: return total
	
	var value = hand[0].val_name
	if value == "J" or value == "Q" or value == "K":
		total = 10;
	elif value == "A":
		total = 11
	else:
		total = value.to_int()
	
	return total
