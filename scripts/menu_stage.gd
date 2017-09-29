# script: main_menu.gd
extends Node

var x = 0
var y = 80
var ydelta = 50

func _ready():
	x = (Globals.get("display/width") / 2) - 50;
	_do_create_buttons()
	pass

func _do_create_buttons():
	var y = (Globals.get("display/height") / 2) - (game.get_possible_cards().size() * ydelta) + ydelta;
	for possible in game.get_possible_cards():
		var menu_button = load("res://scenes/menu_button.tscn")
		var button = menu_button.instance()
		button.set_playing_option(possible)
		button.set_button_position(x, y)
		y += ydelta
		get_node("vbox_buttons").add_child(button)
	pass