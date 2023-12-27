extends Node

@export var title_screen: PackedScene
@export var partie: PackedScene

var music_volume
var gameData = {}

var next_game_name

@onready var save_dir_path = "user://saves/"
@onready var main_dir = DirAccess.open("user://")
@onready var save_dir = DirAccess.open(save_dir_path)
# Called when the node enters the scene tree for the first time.
func _ready():
	if save_dir == null:
		main_dir.make_dir("saves")
	pass # Replace with function body.
	
	main_menu()
	pass # Replace with function body.


func create_json_file(nom_game,save_data):
	var save = FileAccess.open(save_dir_path+str(nom_game + ".json"),FileAccess.WRITE)
	save.store_var(save_data)
	pass

func load_json_file(filename):
	if FileAccess.file_exists(save_dir_path+str(filename + ".json")):
		var datafile = FileAccess.open(save_dir_path+str(filename + ".json"), FileAccess.READ)
		var parsedResult = JSON.parse_string(datafile.get_as_text())
		
		if parsedResult is Dictionary:
			return parsedResult
		else:
			print("Erreur : fichier corrompue...")
	else:
		print("Ce fichier n'existe pas" + filename + ".json")
	pass


func load_game(filename):
	clear_scene()
	var game = partie.instantiate()
	gameData = load_json_file(filename)
	
	var game_scene = get_child(0)
	
	if not FileAccess.file_exists(save_dir_path + str(filename + ".json")):
		return
	
	var get_save_file = FileAccess.open(save_dir_path + str(filename + ".json"), FileAccess.READ)
	
	while get_save_file.get_position() < get_save_file.get_length():
		var json_string = get_save_file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var partie_data = json.get_data()
		
		#on initialise ici
		
		add_child(game)
		get_child(0).curr_GAMEDATA = partie_data
		get_child(0).game_name = filename 
		get_child(0).init_vars(partie_data)
	pass


func clear_scene():
	for i in range(self.get_child_count()-1):
		self.get_child(i).queue_free()
	pass

func main_menu():
	clear_scene()
	var main_menu_instance = title_screen.instantiate()
	add_child(main_menu_instance)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
