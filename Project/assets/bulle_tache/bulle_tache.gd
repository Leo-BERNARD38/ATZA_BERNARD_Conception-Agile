extends Node2D

@export var text_node: Label
var text_content = "Tâche donnée...\n"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func change_task(a):
	text_node.text = "Tâche donnée...\n" + str(a)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
