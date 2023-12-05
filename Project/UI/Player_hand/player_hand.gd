extends Control

@export var current_hand: HBoxContainer
@export var card_slot: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(11):
		match i:
			0:
				var new_slot = card_slot.instantiate()
				current_hand.add_child(new_slot)
				current_hand.get_child(i).changevalue(0)
			1:
				var new_slot = card_slot.instantiate()
				current_hand.add_child(new_slot)
				current_hand.get_child(i).changevalue(0)
			2:
				var new_slot = card_slot.instantiate()
				current_hand.add_child(new_slot)
				current_hand.get_child(i).changevalue(1)
			3:
				var new_slot = card_slot.instantiate()
				current_hand.add_child(new_slot)
				current_hand.get_child(i).changevalue(2)
			4:
				var new_slot = card_slot.instantiate()
				current_hand.add_child(new_slot)
				current_hand.get_child(i).changevalue(5)
			5:
				var new_slot = card_slot.instantiate()
				current_hand.add_child(new_slot)
				current_hand.get_child(i).changevalue(8)
			6:
				var new_slot = card_slot.instantiate()
				current_hand.add_child(new_slot)
				current_hand.get_child(i).changevalue(13)
			7:
				var new_slot = card_slot.instantiate()
				current_hand.add_child(new_slot)
				current_hand.get_child(i).changevalue(20)
			8:
				var new_slot = card_slot.instantiate()
				current_hand.add_child(new_slot)
				current_hand.get_child(i).changevalue(40)
			9:
				var new_slot = card_slot.instantiate()
				current_hand.add_child(new_slot)
				current_hand.get_child(i).changevalue(60)
			10:
				var new_slot = card_slot.instantiate()
				current_hand.add_child(new_slot)
				current_hand.get_child(i).changevalue(100)
		
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
