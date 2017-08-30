# script: game_stage.gd
extends Node

var cards = []
var possible_cards = []
var next_position_x = 0
var next_position_y = 0
var _last_press_object
onready var timer1 = get_node("timer_wait")
onready var anim_bad = utils.get_main_node().find_node("anim_bad")
onready var anim_good = utils.get_main_node().find_node("anim_good")
onready var anim_win = utils.get_main_node().find_node("anim_win")
signal timer_end

func _ready():
	randomize()
	retrieve_textures()
	start_cards()
	pass

func start_game():
	#clean_container()
	
	pass

func retrieve_textures():
	var hidden_texture = load("res://sprites/car.png")
	var possible_textures = [
		load("res://sprites/car1.png"),
		load("res://sprites/car2.png"),
		load("res://sprites/car3.png"),
		load("res://sprites/car4.png"),
		load("res://sprites/car5.png"),
		load("res://sprites/car6.png")
	]
	var number = 1
	for texture in possible_textures:
		for i in range(2): 
			var card_obj = load("res://scripts/card_obj.gd").CardObj.new()
			card_obj.set_showing_sprite(texture)
			card_obj.set_hidden_sprite(hidden_texture)
			card_obj.set_value(number)
			card_obj.set_identifier((i + 3) * card_obj.get_value())
			possible_cards.append(card_obj)
		number += 1
	pass

func start_cards():
	print ("starting cards")
	print ("Set all to 0")
	next_position_x = 0
	next_position_y = 0
	cards = shuffleList(possible_cards)
	for card in cards:
		get_node("container").add_child(load_card(card))
	pass

func clean_container():
	print("Cleaning list")
	cards.clear()
	print("Removing all the children")
	for child in get_node("container").get_children():
		child.queue_free()

func shuffleList(list):
    var shuffledList = []
    var indexList = range(list.size())
    for i in range(list.size()):
        var x = randi()%indexList.size()
        shuffledList.append(list[x])
        indexList.remove(x)
        list.remove(x)
    return shuffledList
	
func load_card(car_obj):
	var scene = load("res://scenes/bcard.tscn")
	var bcard = scene.instance()
	bcard.set_name("scene_"+str(randi()))
	bcard.change_position(next_position_x, next_position_y)
	bcard.set_card_obj(car_obj)
	next_position_x = (next_position_x + bcard.get_width_size() + 5)
	#if next_position_x + bcard.get_width_size() > Globals.get("display/width") / 2:
	if next_position_x + bcard.get_width_size() > Globals.get("display/width"):
		next_position_x = 0
		next_position_y = (next_position_y + bcard.get_height_size() + 5)
	bcard.connect("pressed", self, "_card_is_pressed",[bcard])
	return bcard

func aux_dun(element):
	start_game()
	pass
	
func _card_is_pressed(element):
	if _last_press_object == null:
		_last_press_object = element
	else:
		if (!_last_press_object.get_card_obj().compareIdentifier(element.get_card_obj())):
			if (_last_press_object.get_card_obj().compareTo(element.get_card_obj())):
				element._do_disable_card()
				_last_press_object._do_disable_card()
				if _mark_card_as_check_and_check_win(element, _last_press_object):
					_show_win_anim(4)
					pass
				else:
					_show_good_anim(2)
			else:
				_do_wait_and_hide(1, element, _last_press_object)
				pass
		else:
			print("The card is the same")
		_last_press_object = null
	pass
	
func _mark_card_as_check_and_check_win(card1, card2):
	var has_win = true
	for card in cards:
		if (card.compareTo(card1.get_card_obj())):
			card.set_marked(true)
		else:
			if (card.compareTo(card2.get_card_obj())):
				card.set_marked(true)
			else:
				if(!card.get_marked()):
					has_win = false
	print("has win?" + str(has_win))
	return has_win
	pass
	
func _run_timer(time):
	timer1.set_wait_time(time)
	timer1.set_timer_process_mode(0)
	timer1.connect("timeout", self, "_emit_timer_end_signal")
	timer1.start()
	
func _emit_timer_end_signal():
	emit_signal("timer_end")

func _show_win_anim(time):
	anim_win.show()
	utils.get_main_node().find_node("layer_anim").get_node("anim").play("temple")
	_run_timer(time)
	yield(self, "timer_end")
	anim_win.hide()
	start_game()
	pass

func _show_good_anim(time):
	anim_good.show()
	anim_good.play("default")
	_run_timer(time)
	yield(self, "timer_end")
	anim_good.hide()
	pass
	
func _do_wait_and_hide(time, element1, element2):
	anim_bad.show()
	anim_bad.play("default")
	get_tree().set_pause(true)
	_run_timer(time)
	yield(self, "timer_end")
	element1._do_show_hide()
	element2._do_show_hide()
	get_tree().set_pause(false)
	anim_bad.hide()