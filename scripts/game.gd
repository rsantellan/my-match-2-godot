# script game.gd

extends Node

const GROUP_CAR = "cards"
const GROUP_BLOCKS = "blocks"

var playing_card
var possible_cards = []
var _possible_cards = {}
var _initialized = false

var _json_url = 'http://localhost/data.php'
#var _json_url = 'http://rodrigosantellan.com/data.php'

func _ready():
	pass

func _load_from_url():
	#var json_data = {}
	#var aux = http_manager.http_get(_json_url)
	#json_data.parse_json(aux)
	#for item in json_data['items']:
	#	_possible_cards[item['name']] = item
	#	possible_cards.append(item['name'])
	pass

func load_possible_cards():
	if !_initialized:
		_load_from_url()
		print("possible cards")
		print(possible_cards)
		if(possible_cards.size() == 0):
			possible_cards.append("cars")
			possible_cards.append("family")
		_initialized = true
	pass
	
func set_playing_card(option):
	if !_initialized:
		load_possible_cards()
	if(possible_cards.has(option)):
		playing_card = option
		
		return true
	return false
	pass

func get_possible_cards():
	if !_initialized:
		load_possible_cards()
	return possible_cards
	
func get_playing_card():
	if playing_card == null:
		return "cars"
	return playing_card
	
func get_playing_textures():
	var textures = {}
	if(get_playing_card() == "family"):
		textures = _load_family_textures()
	else:
		if(get_playing_card() == "family"):
			textures = _load_car_textures()
		else:
			if(_possible_cards.has(get_playing_card())):
				textures = _load_online_textures()
	if(textures.empty()):
		textures = _load_car_textures()
	return textures
	pass

func _load_online_textures():
	var textures = {}
	var path = "user://"+get_playing_card()+"/sprites/front/"
	var name = "hidden.png"
	http_manager.save_image_from_url(path, name, _possible_cards[get_playing_card()]['hidden'])
	textures["hidden"] = load(path + name)
	textures["possible"] = []
	for itemName in _possible_cards[get_playing_card()]['possible'].keys():
		print ("aca + " + itemName)
		http_manager.save_image_from_url(path, itemName, _possible_cards[get_playing_card()]['possible'][itemName])
		textures["possible"].append(load(path + name))
	return textures;
	
# This is a fallback!! just in case
func _load_car_textures():
	var textures = {}
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = [
		load("res://sprites/cars/car1.png"),
		load("res://sprites/cars/car2.png"),
		load("res://sprites/cars/car3.png"),
		load("res://sprites/cars/car4.png"),
		load("res://sprites/cars/car5.png"),
		load("res://sprites/cars/car6.png")
	]
	return textures

func _load_family_textures():
	var textures = {}
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = [
		load("res://sprites/family/family1.png"),
		load("res://sprites/family/family2.png"),
		load("res://sprites/family/family3.png"),
		load("res://sprites/family/family4.png"),
		load("res://sprites/family/family5.png"),
		load("res://sprites/family/family6.png")
	]
	return textures