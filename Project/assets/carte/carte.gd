extends Node2D

@onready var card_text := $Sprite2D/Valeur_carte as Label
@onready var audio_node := $Son as AudioStreamPlayer2D
var valeur_carte
var animation_weight = 0.2
var is_hovered = false
var base_scale = 0.8
var zoom = 1.3
# Called when the node enters the scene tree for the first time.



func valuechange(a):
	valeur_carte = a
	update_card_state()

func update_card_state():
	card_text.text = str(valeur_carte)

func _ready():
	var p_px = get_parent().global_position.x
	var p_py = get_parent().global_position.y
	var p_sx = get_parent().size.x
	var p_sy = get_parent().size.y
	valuechange(100)
	changepos((p_px + (p_sx/2)),(p_py + (p_sy/2)))
	pass # Replace with function body.

func resize_animation(boolean):
	if(boolean == true):
		self.scale.x = lerpf(self.scale.x, base_scale * zoom,animation_weight)
		self.scale.y = lerpf(self.scale.y, base_scale * zoom,animation_weight)
	else:
		self.scale.x = lerpf(self.scale.x, base_scale,animation_weight)
		self.scale.y = lerpf(self.scale.y, base_scale,animation_weight)
	pass

func changepos(x,y):
	self.global_position.x = x
	self.global_position.y = y

func _on_clickingarea_mouse_entered():
	is_hovered = true
	audio_node.play()
	pass # Replace with function body.


func _on_clickingarea_mouse_exited():
	is_hovered = false
	audio_node.stop()
	pass # Replace with function body.

func _physics_process(delta):
	resize_animation(is_hovered)
