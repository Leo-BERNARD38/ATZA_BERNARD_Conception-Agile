extends Control

@export var current_hand: HBoxContainer
@export var card_slot: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_slot = card_slot.instantiate()
	for i in range(10):
		if(i==0):
			current_hand.add_child(new_slot)
			current_hand.get_child(i).changevalue(0)
		if(i==1):
			current_hand.add_child(new_slot)
			current_hand.get_child(i).changevalue(0)
		if(i==2):
			current_hand.add_child(new_slot)
			current_hand.get_child(i).changevalue(1)
		if(i==3):
			current_hand.add_child(new_slot)
			current_hand.get_child(i).changevalue(2)
		if(i==4):
			current_hand.add_child(new_slot)
			current_hand.get_child(i).changevalue(5)
		if(i==5):
			current_hand.add_child(new_slot)
			current_hand.get_child(i).changevalue(8)
		if(i==6):
			current_hand.add_child(new_slot)
			current_hand.get_child(i).changevalue(13)
		if(i==7):
			current_hand.add_child(new_slot)
			current_hand.get_child(i).changevalue(20)
		if(i==8):
			current_hand.add_child(new_slot)
			current_hand.get_child(i).changevalue(40)
		if(i==9):
			current_hand.add_child(new_slot)
			current_hand.get_child(i).changevalue(60)
		if(i==10):
			current_hand.add_child(new_slot)
			current_hand.get_child(i).changevalue(100)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
