extends Node2D



func add_line(chars, manche):
	get_node("VBoxContainer/res"+str(manche)).text = chars
	pass

