extends Control

@export var fade: ColorRect
@export var animation: AnimationPlayer
@export var submenu_create: PackedScene
@export var submenu_load: PackedScene

@export var hoveringSFX: AudioStreamPlayer2D
@export var selectedSFX: AudioStreamPlayer2D
@export var backSFX: AudioStreamPlayer2D

@onready var main_dir = DirAccess.open("user://")
@onready var save_dir = DirAccess.open("user://saves")

var animation_weight = 0.1
# Called when the node enters the scene tree for the first time.


func _ready():
	animation.play("fade_in")
	
	if save_dir == null:
		main_dir.make_dir("saves")
	pass # Replace with function body.

func get_hovered_sound():
	hoveringSFX.play()
	pass

func get_selected_sound():
	selectedSFX.play()
	pass

func get_back_sound():
	backSFX.play()
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_menu_animation_animation_finished(anim_name):
	if anim_name== "fade_in":
		fade.queue_free()
	pass # Replace with function body.


func _on_quit_pressed():
	get_selected_sound()
	
	get_tree().quit()
	pass # Replace with function body.


func _on_create_pressed():
	get_selected_sound()
	
	
	var new_create_subm = submenu_create.instantiate()
	add_child(new_create_subm)
	pass # Replace with function body.


func _on_load_pressed():
	get_selected_sound()
	
	
	var new_load_subm = submenu_load.instantiate()
	add_child(new_load_subm)
	pass # Replace with function body.


func _on_create_mouse_entered():
	get_hovered_sound()
	pass # Replace with function body.


func _on_load_mouse_entered():
	get_hovered_sound()
	pass # Replace with function body.


func _on_quit_mouse_entered():
	get_hovered_sound()
	pass # Replace with function body.
