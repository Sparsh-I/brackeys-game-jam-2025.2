extends Node2D

@onready var deck = $Deck
@onready var card_manager = $CardManager
@onready var player_hand = $PlayerHand
@onready var dealer_hand = $DealerHand
@onready var hit_button = $UI/Hit
@onready var stand_button = $UI/Stand

var PLAYER_POS: Vector2
var DEALER_POS: Vector2

func deal():
	for i in range(2):
		dealer_hit()
		player_hit()

func player_hit():
	var card_data = deck.pick_card()
	if card_data.size() == 0:
		return
	var card = player_hand.add_card_to_hand(card_data, PLAYER_POS)
	card_manager.add_child(card)

func player_stand():
	while dealer_hand.hand_value < 17:
		dealer_hit()
	
	for card in dealer_hand.hand:
		if card.face_down:
			card.flip_over()
	
	end_round()

func dealer_hit():
	# deal card for the dealer
	var card_data = deck.pick_card()
	if card_data.size() == 0:
		return
	var card = dealer_hand.add_card_to_hand(card_data, DEALER_POS)
	card_manager.add_child(card)

func end_round():
	if (player_hand.bust and dealer_hand.bust) or (player_hand.hand_value == dealer_hand.hand_value):
		print("\n-----------Chips back-----------")
	elif dealer_hand.bust:
		print("\n-----------Victory-----------")
	elif player_hand.bust:
		print("\n-----------Loss-----------")
	elif player_hand.hand_value > dealer_hand.hand_value:
		print("\n-----------Victory-----------")
	else:
		print("\n-----------Loss-----------")

func _on_hit_pressed():
	player_hit()
	dealer_hit()

func _on_stand_pressed():
	player_stand()

func _ready():
	var screen_size = get_viewport().get_visible_rect().size
	PLAYER_POS = Vector2(screen_size.x / 2, screen_size.y - 100)
	DEALER_POS = Vector2(screen_size.x / 2, 100)
	
	deal()
	hit_button.pressed.connect(self._on_hit_pressed)
	stand_button.pressed.connect(self._on_stand_pressed)
