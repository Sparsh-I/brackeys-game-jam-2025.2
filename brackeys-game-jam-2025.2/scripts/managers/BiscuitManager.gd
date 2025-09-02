extends Node2D

var description_box: RichTextLabel
var active_biscuit: Biscuit
var is_hovering_on_biscuit

# set a new biscuit powerup as the active one
func set_active_biscuit(biscuit: Biscuit):
	if active_biscuit and active_biscuit != biscuit:
		active_biscuit.deactivate()
	active_biscuit = biscuit

# connect hovering signals to the biscuit
func connect_biscuit_signals(biscuit: Biscuit):
	biscuit.connect("hovered", Callable(self, "on_hovered_over_biscuit"))
	biscuit.connect("hovered_off", Callable(self, "on_hovered_off_biscuit"))

# set the powerup description box to invisible
func _ready():
	description_box = get_node("/root/Game/UI/BiscuitDescription")
	description_box.visible = false

# set the powerup description text and the box to visible
func on_hovered_over_biscuit(biscuit: Biscuit):
	description_box.text = biscuit.description
	print(biscuit.description)
	description_box.visible = true
	
	if !is_hovering_on_biscuit:
		is_hovering_on_biscuit = true
		biscuit.set_highlighted_texture(true)

func on_hovered_off_biscuit(biscuit: Biscuit):
	description_box.visible = false
	is_hovering_on_biscuit = false
	biscuit.set_highlighted_texture(false)

func spawn_biscuit(biscuit: Biscuit, slot, player_hand):
	biscuit.slot = slot
	biscuit.player_hand = player_hand
	biscuit.activate()
	connect_biscuit_signals(biscuit)
	return biscuit
	
