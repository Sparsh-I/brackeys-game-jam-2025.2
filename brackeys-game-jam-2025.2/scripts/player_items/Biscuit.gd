extends Node2D
class_name Biscuit

var manager: BiscuitManager
var description = ""
var active = false

var player_hand = null
var slot: Node = null
const SCALE = 7

# signals for if a biscuit is being hovered over
signal hovered
signal hovered_off

func set_description(text):
	description = text

func activate():
	#BiscuitManager.set_active_biscuit(self)
	#active = true
	if slot:
		slot.add_child(self)
		position = Vector2(0, 0)
		print("Spawned", self.name, "at slot", slot.name)
	#apply_powerup()

func deactivate():
	active = false
	if self.get_parent():
		self.get_parent().remove_child(self)
	remove_powerup()

func apply_powerup():
	pass

func remove_powerup():
	pass

func reapply_powerup():
	remove_powerup()
	apply_powerup()

func set_highlighted_texture(hovered):
	pass
