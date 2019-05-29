# script game.gd

extends Node

const GROUP_CAR = "cards"
const GROUP_BLOCKS = "blocks"

var playing_card
var possible_cards = []
var _possible_cards = {}
var _initialized = false
var _max_cards = 15
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
		#print("possible cards")
		#print(possible_cards)
		if(possible_cards.size() == 0):
			possible_cards.append("1 - Autos")
			possible_cards.append("2 - Familia")
			possible_cards.append("3 - Frozen")
			possible_cards.append("4 - Sirenita")
			possible_cards.append("5 - Sofia")
			possible_cards.append("6 - dora")
			possible_cards.append("7 - mickey")
			possible_cards.append("8 - Paw Patrol")
			possible_cards.append("9 - Doctora Juguetes")
			possible_cards.append("10 - Peppa Pig")
			possible_cards.append("11 - Hello Kitty")
			possible_cards.append("12 - Bella Durmiente")
			possible_cards.append("13 - Super DC Girls")
			possible_cards.append("14 - LOL")
			possible_cards.append("15 - Troll")
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
		return "1 - Autos"
	return playing_card
	
func get_playing_textures():
	var textures = {}
	if(get_playing_card() == "1 - Autos"):
		textures = _load_car_textures()
	if(get_playing_card() == "2 - Familia"):
		textures = _load_family_textures()
	if(get_playing_card() == "3 - Frozen"):
		textures = _load_frozen_textures()
	if(get_playing_card() == "4 - Sirenita"):
		textures = _load_mermaid_textures()
	if(get_playing_card() == "5 - Sofia"):
		textures = _load_sofia_textures()
	if(get_playing_card() == "6 - dora"):
		textures = _load_dora_textures()
	if(get_playing_card() == "7 - mickey"):
		textures = _load_mickey_textures()
	if(get_playing_card() == "8 - Paw Patrol"):
		textures = _load_paw_textures()
	if(get_playing_card() == "9 - Doctora Juguetes"):
		textures = _load_doc_textures()
	if(get_playing_card() == "10 - Peppa Pig"):
		textures = _load_peppa_textures()
	if(get_playing_card() == "11 - Hello Kitty"):
		textures = _load_kitty_textures()
	if(get_playing_card() == "12 - Bella Durmiente"):
		textures = _load_belladurmiente_textures()
	if(get_playing_card() == "13 - Super DC Girls"):
		textures = _load_dc_girls_textures()
	if(get_playing_card() == "14 - LOL"):
		textures = _load_lol_textures()
	if(get_playing_card() == "15 - Troll"):
		textures = _load_troll_textures()
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
		#print ("aca + " + itemName)
		http_manager.save_image_from_url(path, itemName, _possible_cards[get_playing_card()]['possible'][itemName])
		textures["possible"].append(load(path + name))
	return textures;
	
# This is a fallback!! just in case
func _load_car_textures():
	var textures = {}
	var itemsQuantity = 6
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = _load_rand_textures(itemsQuantity, "res://sprites/cars/car")
	return textures

func _load_family_textures():
	var textures = {}
	var itemsQuantity = 6
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = _load_rand_textures(itemsQuantity, "res://sprites/family/family")
	return textures

func _load_mermaid_textures():
	var textures = {}
	var itemsQuantity = 6
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = _load_rand_textures(itemsQuantity, "res://sprites/mermaid/mermaid")
	return textures

func _load_frozen_textures():
	var textures = {}
	var itemsQuantity = 13
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = _load_rand_textures(itemsQuantity, "res://sprites/frozen/frozen")
	return textures

func _load_dora_textures():
	var textures = {}
	var itemsQuantity = 6
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = _load_rand_textures(itemsQuantity, "res://sprites/dora/dora")
	return textures
	
func _load_sofia_textures():
	var textures = {}
	var itemsQuantity = 6
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = _load_rand_textures(itemsQuantity, "res://sprites/sofia/sofia")
	return textures
	
func _load_mickey_textures():
	var textures = {}
	var itemsQuantity = 6
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = _load_rand_textures(itemsQuantity, "res://sprites/mickey/mickey")
	return textures
	
func _load_paw_textures():
	var textures = {}
	var itemsQuantity = 13
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = _load_rand_textures(itemsQuantity, "res://sprites/pawpatrol/paw")
	return textures
	
func _load_doc_textures():
	var textures = {}
	var itemsQuantity = 11
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = _load_rand_textures(itemsQuantity, "res://sprites/doc/doc")
	return textures
	
func _load_peppa_textures():
	var textures = {}
	var itemsQuantity = 15
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = _load_rand_textures(itemsQuantity, "res://sprites/peppa/peppa")
	return textures
	
func _load_kitty_textures():
	var textures = {}
	var itemsQuantity = 11
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = _load_rand_textures(itemsQuantity, "res://sprites/kitty/kitty")
	return textures
	
func _load_belladurmiente_textures():
	var textures = {}
	var itemsQuantity = 8
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = _load_rand_textures(itemsQuantity, "res://sprites/belladurmiente/bella")
	return textures
	
func _load_dc_girls_textures():
	var textures = {}
	var itemsQuantity = 10
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = _load_rand_textures(itemsQuantity, "res://sprites/supergirls/dc")
	return textures
	
func _load_lol_textures():
	var textures = {}
	var itemsQuantity = 17
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = _load_rand_textures(itemsQuantity, "res://sprites/lol/lol")
	return textures
	
func _load_troll_textures():
	var textures = {}
	var itemsQuantity = 14
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = _load_rand_textures(itemsQuantity, "res://sprites/troll/troll")
	return textures
	
func _load_rand_textures(itemsQuantity, path):
	var selected = {}
	var possible = []
	var textures_names = []
	if itemsQuantity < _max_cards:
		for i in range(1, itemsQuantity + 1):
			selected[i] = i
	else:
		while selected.size() <= itemsQuantity or selected.size() < _max_cards:
			var rand_number = randi()%itemsQuantity+1
			if not selected.has(rand_number):
				selected[rand_number] = rand_number
	for i in selected.keys():
		textures_names.append(str(path) + str(i) + ".png")
	for file in textures_names:
		possible.append(load(file))
	return possible