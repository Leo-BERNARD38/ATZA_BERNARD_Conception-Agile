extends Control

@export var fade: ColorRect
@export var animation: AnimationPlayer
@export var submenu_create: PackedScene
@export var submenu_load: PackedScene


@export var title_screen_song: AudioStreamPlayer2D
@export var hoveringSFX: AudioStreamPlayer2D
@export var selectedSFX: AudioStreamPlayer2D
@export var backSFX: AudioStreamPlayer2D

@onready var game_instance = get_parent()


var volume_song = 1.2
var volume_effects = 1.6

var animation_weight = 0.1
# Called when the node enters the scene tree for the first time.


func _ready():
	title_screen_song.volume_db = -80 + 50*volume_song
	hoveringSFX.volume_db = -80 + 50*volume_effects
	selectedSFX.volume_db = -80 + 50*(volume_effects-0.3)
	backSFX.volume_db = -80 + 50*volume_effects
	animation.play("fade_in")

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


func _on_main_menu_music_finished():
	title_screen_song.play()
	pass # Replace with function body.



func _on_h_slider_value_changed(value):
	title_screen_song.volume_db = -80 + value*volume_song  #-80 -30 20 range de 100 en partant de -80
	hoveringSFX.volume_db = -80 + value*volume_effects
	selectedSFX.volume_db = -80 + value*(volume_effects-0.2)
	backSFX.volume_db = -80 + value*volume_effects
	pass # Replace with function body.
