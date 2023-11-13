extends Node2D

@onready var card_text := $Sprite2D/Valeur_carte as Label
var valeur_carte
# Called when the node enters the scene tree for the first time.



func valuechange(a):
	valeur_carte = a
	update_card_state()

func update_card_state():
	card_text.text = str(valeur_carte)

func _ready():
	valuechange(100)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


