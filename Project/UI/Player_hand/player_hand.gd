extends Control

@export var current_hand: HBoxContainer
@export var DEBUG_TEXT: Label
var took_a_card = false
var active_card_node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func set_debug_text(a):
	DEBUG_TEXT.text = str(a)
