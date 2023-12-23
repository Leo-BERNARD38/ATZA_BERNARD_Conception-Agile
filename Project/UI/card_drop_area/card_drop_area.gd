extends Area2D

@export var player_hand_node: Control
@export var label_debug: Label 
var is_taken = false
var card_node
var card_value
var is_hovered

# Called when the node enters the scene tree for the first time.
func _ready():
	is_hovered = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (!is_taken):
		if (is_hovered):
			label_debug.text = "ça hover"
		else:
			label_debug.text = ""
	if (Input.is_action_just_released("left_click") and (is_taken == false) and (is_hovered) and (player_hand_node.took_a_card)):
		#Input.is_action_just_released("left_click") et (is_hovered) non suspects
		player_hand_node.active_card_node.is_placed = true
		card_value = player_hand_node.active_card_node.valeur_carte
		is_taken = true
		player_hand_node.active_card_node.new_pos = self.global_position
		label_debug.text = str(player_hand_node.active_card_node.valeur_carte)
		player_hand_node.took_a_card = false
		player_hand_node.active_card_node = null
		pass
	pass


func _on_area_entered(area):
	if (!is_taken):
		is_hovered = true
	pass # Replace with function body.



func _on_area_exited(area):
	if (!is_taken):
		is_hovered = false
	pass # Replace with function body.
