extends Node2D


var scene = "res://scenes/test_scene.tscn"


#COMMENTAIRE D'EN-TÊTE
#... ON FAIT PAS GRAND CHOSE ICI, A PART DU DEBUG, POUR LE MOMENT...


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("reload")):
		get_tree().change_scene_to_file(scene) #ça nous permet de changer la scene actuelle en la scene de la variable du même nom, vu que c'est la même on reload simplement.
	pass

func _physics_process(delta):
	pass
