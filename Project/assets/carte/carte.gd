extends Node2D

@onready var card_text := $Sprite2D/Valeur_carte as Label
@onready var audio_node := $Son as AudioStreamPlayer2D
@export var valeur_carte = 0.0
@onready var Player_hand_node := $".." as Control
var animation_weight = 0.2
var is_hovered = false
var base_scale = 0.3
var base_size = Vector2.ZERO
@onready var base_pos = self.global_position
var zoom = 1.3
@export var current_state = true
var is_placed = false
var new_pos
# Called when the node enters the scene tree for the first time.




func _ready():
	new_pos = Vector2.ZERO
	base_size.x = 256
	base_size.y = 356
#	var p_px = get_parent().global_position.x
#	var p_py = get_parent().global_position.y
#	var p_sx = get_parent().size.x
#	var p_sy = get_parent().size.y
	valuechange(valeur_carte)
#	changepos((p_px + (p_sx/2)),(p_py + (p_sy/2)))
	pass # Replace with function body.

func reset_pos():
	global_position.x = lerpf(global_position.x,base_pos.x, animation_weight)
	global_position.y = lerpf(global_position.y,base_pos.y, animation_weight)

func valuechange(a):
	valeur_carte = a
	update_card_state()

func update_card_state():
	card_text.text = str(valeur_carte)

func drag():
	global_position.x = get_global_mouse_position().x 
	global_position.y = get_global_mouse_position().y
	pass

func drop():
	if (is_placed):
		global_position.x = lerpf(global_position.x,new_pos.x, animation_weight)
		global_position.y = lerpf(global_position.y,new_pos.y, animation_weight)
	else:
		reset_pos()
	pass

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

func get_on_top(a):
	if(a):
		z_index = 2
	else:
		z_index = 1
	pass

func get_to_pos(a):
	is_placed == true
	global_position.x = lerpf(global_position.x,a.x, animation_weight)
	global_position.y = lerpf(global_position.y,a.y, animation_weight)

func on_pickup():
	
	pass


func _on_clickingarea_mouse_entered():
	if Player_hand_node.took_a_card == false:
		is_hovered = true
		if(current_state == true):
			audio_node.play()
	pass # Replace with function body.

func _on_clickingarea_mouse_exited():
	is_hovered = false
	if(current_state == true):
		audio_node.stop()
	pass # Replace with function body.

func _process(delta):
	if((is_hovered) and (Input.is_action_pressed("left_click")) and (current_state) and ((Player_hand_node.active_card_node == self) or (Player_hand_node.active_card_node == null))):
			Player_hand_node.set_debug_text(self)
			Player_hand_node.active_card_node = self
			Player_hand_node.took_a_card = true
			drag()
			get_on_top(true)
	pass

func _physics_process(delta):
	if(Player_hand_node.active_card_node == null):
		resize_animation(is_hovered)
	if (is_placed):
		drop()
	else:
		if(!Input.is_action_pressed("left_click")):
			drop()
			Player_hand_node.active_card_node = null
			if Player_hand_node.took_a_card == true:
				Player_hand_node.took_a_card = false
			get_on_top(false)
		pass

