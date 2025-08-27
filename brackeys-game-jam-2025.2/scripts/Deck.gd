extends Node2D

var cards = []

func _ready():
	for suit in range(0, 4):
		for value in range(0, 13):
			cards.append({"suit": suit, "value": value})
	cards.shuffle()

func pick_card() -> Dictionary:
	if cards.is_empty():
		print("Deck is empty!")
		return {}
	return cards.pop_back()
