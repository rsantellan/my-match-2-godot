# script: menu_button.gd
extends Node

var _playing_option

func _ready():
	get_node("btn_menu").connect("pressed", self, "_on_pressed")
	pass

func _on_pressed():
	print("been pressed")
	game.playing_card = _playing_option
	stage_manager.change_stage(stage_manager.STAGE_GAME)
	pass
	
func set_playing_option(option):
	get_node("btn_menu").set_text(option)
	_playing_option = option
	pass

func set_button_position(x, y):
	get_node("btn_menu").set_pos(Vector2(x, y))
	pass

func get_playing_option():
	return _playing_option
	pass