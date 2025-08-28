extends Node2D

@onready var deck = $Deck
@onready var card_manager = $CardManager

@onready var player_hand = $PlayerHand
@onready var dealer_hand = $DealerHand
@onready var player_bar = $PlayerBar
@onready var dealer_bar = $DealerBar

@onready var hit_button = $UI/Hit
@onready var stand_button = $UI/Stand
@onready var reset_button = $UI/Reset

@onready var round_message = $UI/RoundMessage

var is_standing = false

func _ready():	
	reset_game()

func update_bars():
	player_bar.set_bar_texture(player_hand.hand_value)
	player_hand.score.text = "Player: %s" % player_hand.hand_value
	if !is_standing: 
		dealer_bar.set_bar_texture(dealer_hand.calculate_visible_hand_value())
		dealer_hand.score.text = "Dealer: %s" % dealer_hand.calculate_visible_hand_value()
	else: 
		dealer_bar.set_bar_texture(dealer_hand.hand_value)
		dealer_hand.score.text = "Dealer: %s" % dealer_hand.hand_value

func deal():
	round_message.text = "Round In-Play"
	for i in range(2):
		dealer_hit()
		player_hit()

func player_hit():
	var card_data = deck.pick_card()
	if card_data.size() == 0:
		return
	var card = player_hand.add_card_to_hand(card_data)
	card_manager.add_child(card)
	update_bars()

func player_stand():
	is_standing = true
	
	while dealer_hand.hand_value < 17:
		dealer_hit()
	
	for card in dealer_hand.hand:
		if card.face_down:
			card.flip_over()
	
	update_bars()	
	end_round()

func dealer_hit():
	# deal card for the dealer
	var card_data = deck.pick_card()
	if card_data.size() == 0:
		return
	var card = dealer_hand.add_card_to_hand(card_data)
	card_manager.add_child(card)
	update_bars()

func end_round():	
	if (player_hand.bust and dealer_hand.bust) or (player_hand.hand_value == dealer_hand.hand_value):
		round_message.text = "Chips back"
	elif dealer_hand.bust:
		round_message.text = "Victory"
	elif player_hand.bust:
		round_message.text = "Loss"
	elif player_hand.hand_value > dealer_hand.hand_value:
		round_message.text = "Victory"
	else:
		round_message.text = "Loss"

func reset_game():
	is_standing = false
	reset_cards()
	player_bar.set_bar_texture(0)
	dealer_bar.set_bar_texture(0)
	deal()

func reset_cards():
	var children = card_manager.get_children()
	for child in children:
		card_manager.remove_child(child)
	
	deck.reset()
	player_hand.reset_hand()
	dealer_hand.reset_hand()

func _on_hit_pressed():
	if is_standing: return
	print("Hit clicked!")
	player_hit()
	dealer_hit()

func _on_stand_pressed():
	if is_standing: return
	print("Stand clicked!")
	player_stand()

func _on_reset_pressed():
	reset_game()
