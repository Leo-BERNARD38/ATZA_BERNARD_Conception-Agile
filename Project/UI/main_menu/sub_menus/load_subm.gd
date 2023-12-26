extends ColorRect

@onready var main_menu = get_parent()
@export var drop_menu: OptionButton

# Called when the node enters the scene tree for the first time.
func _ready():
	var save_dir = DirAccess.open("saves")
	save_dir.list_dir_begin()
	var file_name = save_dir.get_next()
	var index = 0 
	while file_name != "":
		if save_dir.current_is_dir():
			print("directory found... not a save file")
		else:
			if (file_name.ends_with(".json")):
				print("save file found : " + file_name)
				drop_menu.add_item(str(file_name),index)
				index+= 1
		file_name = save_dir.get_next()
	drop_menu.select(-1)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_pressed():
	main_menu.get_back_sound()
	
	queue_free()
	pass # Replace with function body.


func _on_option_button_item_selected(index):
	main_menu.get_selected_sound()
	
	
	pass # Replace with function body.