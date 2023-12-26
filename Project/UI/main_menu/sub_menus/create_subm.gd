extends ColorRect

@export var list: OptionButton
@export var Moy: Button
@export var Med: Button

@onready var main_menu = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_retour_pressed():
	main_menu.get_back_sound()
	
	queue_free()
	pass # Replace with function body.



func _on_option_button_item_selected(index):
	main_menu.get_selected_sound()
	
	Moy.disabled = false
	Med.disabled = false
	pass # Replace with function body.


func _on_mediane_pressed():
	main_menu.get_selected_sound()
	
	
	pass # Replace with function body.


func _on_moyenne_pressed():
	main_menu.get_selected_sound()
	
	
	pass # Replace with function body.
