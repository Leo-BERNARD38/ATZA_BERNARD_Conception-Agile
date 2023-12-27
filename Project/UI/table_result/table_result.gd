extends Node2D



func add_line(chars, manche):
	get_node("VBoxContainer/res"+str(manche)).text = str(chars)
	pass

func change_gamemode(chars):
	get_node("VBoxContainer/Gamemode").text = "Mode de jeu : " + chars
