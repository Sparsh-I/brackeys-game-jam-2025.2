extends Node
class_name Hand

@onready var value_bar = $ValueBar

var hand_value = 0
var bust = false

var hand = []
const CARD_SPACING = 75
const FAN_ANGLE_STEP = 10
const FAN_POSITION_STEP = 10

var screen_size: Vector2
var center: Vector2

func calculate_hand_value() -> int:
	var total = 0
	var ace_count = 0
	
	for card in hand:
		if card.active:
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
	var count = cards.size()
	if count == 0:
		return
	
	# calculate the total width of all the cards in the hand
	var total_width = (count - 1) * spacing
	var start_x = center_x - total_width / 2
	
	# calculate middle index to calculate which cards to fan index
	var mid = float(count - 1) / 2.0
	for i in range(count):
		var card = cards[i]
		card.position = Vector2(start_x + i * spacing, y_val)
		
		# calculate card offset from the middle and form the fan pattern
		var offset = i - mid
		
		card.rotation_degrees = offset * FAN_ANGLE_STEP
		card.position.y += abs(offset) * FAN_POSITION_STEP

func update_value_bar():
	value_bar.get_bar_texture()

func _ready():
	# calculate the screen size and the centre of the screen
	screen_size = get_viewport().get_visible_rect().size
	center = screen_size / 2
	bust = false

func _process(delta: float):
	update_value_bar

func reset_hand():
	hand = []
	hand_value = 0
	bust = false
