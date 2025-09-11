extends Node2D

const COLLISION_MASK_BISCUIT = 1

var description_box: RichTextLabel
var active_biscuit: Biscuit
var is_hovering_on_biscuit

## set a new biscuit powerup as the active one
#func set_active_biscuit(biscuit: Biscuit):
	#if active_biscuit and active_biscuit != biscuit:
		#active_biscuit.deactivate()
	#active_biscuit = biscuit

# connect hovering signals to the biscuit
func connect_biscuit_signals(biscuit: Biscuit):
	biscuit.connect("hovered", Callable(self, "on_hovered_over_biscuit"))
	biscuit.connect("hovered_off", Callable(self, "on_hovered_off_biscuit"))
	biscuit.connect("clicked", Callable(self, "on_clicked_biscuit"))

# set the powerup description box to invisible
func _ready():
	description_box = get_node("/root/Game/UI/BiscuitDescription")
	description_box.visible = false

# set the powerup description text and the box to visible
func on_hovered_over_biscuit(biscuit: Biscuit):
	description_box.text = biscuit.description
	description_box.visible = true
	
	if !is_hovering_on_biscuit:
		is_hovering_on_biscuit = true
		biscuit.set_highlighted_texture(true)

func on_hovered_off_biscuit(biscuit: Biscuit):
	description_box.visible = false
	var new_biscuit_hovered = raycast_check_for_biscuit()
	if new_biscuit_hovered:
		new_biscuit_hovered.set_highlighted_texture(true)
		is_hovering_on_biscuit = true
	else:
		is_hovering_on_biscuit = false
		biscuit.set_highlighted_texture(false)

func on_clicked_biscuit(biscuit: Biscuit):
	print("Manager saw biscuit click:", biscuit.name)
	
	# Apply the effect
	biscuit.apply_powerup()
	

func spawn_biscuit(biscuit: Biscuit, slot, player_hand):
	biscuit.slot = slot
	biscuit.player_hand = player_hand
	biscuit.activate()
	connect_biscuit_signals(biscuit)
	return biscuit

func raycast_check_for_biscuit():
	var space_state = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = COLLISION_MASK_BISCUIT
	var results = space_state.intersect_point(parameters)
	
	if results.size() > 0:
		#return get_biscuit_with_highest_z_value(results)
		var biscuit = get_biscuit_from_collider(results[0].collider)
		return biscuit
	return null

func get_biscuit_from_collider(collider: Object) -> Biscuit:
	var node = collider
	while node and not (node is Biscuit):
		node = node.get_parent()
	return node
