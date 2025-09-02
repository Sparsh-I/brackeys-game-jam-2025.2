extends Hand

@onready var score = $"../UI/PlayerScore"

func add_card_to_hand(card_data):
	if hand_value >= 21:
		return null
	
	var card = preload("res://scenes/card.tscn").instantiate()
	card.set_card(card_data["suit"], card_data["value"], false)
	
	# add card to hand, calculate the new value and arrange the cards as needed
	hand.append(card)
	hand_value = calculate_hand_value()
	arrange_cards(hand, center.x, 450)
	
	if hand_value > 21:
		bust = true
	
	return card
