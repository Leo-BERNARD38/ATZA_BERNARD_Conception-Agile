extends Node2D


var scene = "res://scenes/test_scene.tscn"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("reload")):
		get_tree().change_scene_to_file(scene)
	pass

func _physics_process(delta):
	pass
