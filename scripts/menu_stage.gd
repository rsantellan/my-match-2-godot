# script: main_menu.gd
extends Node

var x = 0
var y = 80
var ydelta = 50

func _ready():
	x = 20; #(Globals.get("display/width") / 2) - 50;
	_do_create_buttons()
	pass

func _do_create_buttons():
	var y = 20; #(Globals.get("display/height") / 2) - (game.get_possible_cards().size() * ydelta) + (ydelta * 5);
	var fullWidth = Globals.get("display/width");
	var fullHeight = Globals.get("display/height");
	var startWidth = x;
	var startHeight = y;
	print(fullWidth)
	print(fullHeight)
	for possible in game.get_possible_cards():
		var menu_button = load("res://scenes/menu_button.tscn")
		var button = menu_button.instance()
		button.set_playing_option(possible)
		if x + (2 * ydelta) + (possible.length() * 15) >= fullWidth:
			x = startWidth
			y += ydelta
		button.set_button_position(x, y)
		x += (2 * ydelta) + (possible.length() * 15);
		get_node("vbox_buttons").add_child(button)
	pass