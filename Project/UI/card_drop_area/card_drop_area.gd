extends Area2D

@export var player_hand_node: Control
@export var label_debug: Label 
var is_taken = false
var card_node
var card_value

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(player_hand_node.active_card_node != null):
		label_debug.text = str(player_hand_node.active_card_node.new_pos)
	pass


func _on_area_entered(area):
	if Input.is_action_just_released("left_click") and (is_taken == false) and (player_hand_node.took_a_card):
		card_value = player_hand_node.active_card_node.valeur_carte
		is_taken == true
		player_hand_node.took_a_card = false
		card_value = player_hand_node.active_card_node.valeur_carte
		player_hand_node.active_card_node.is_placed == true
		player_hand_node.active_card_node.new_pos = global_position
		player_hand_node.active_card_node = null
		pass
	pass # Replace with function body.
