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
		#print("possible cards")
		#print(possible_cards)
		if(possible_cards.size() == 0):
			possible_cards.append("1 - cars")
			possible_cards.append("2 - family")
			possible_cards.append("3 - frozen")
			possible_cards.append("4 - mermaid")
			possible_cards.append("5 - sofia")
			possible_cards.append("6 - dora")
			possible_cards.append("7 - mickey")
			possible_cards.append("8 - Paw Patrol")
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
		return "1 - cars"
	return playing_card
	
func get_playing_textures():
	var textures = {}
	if(get_playing_card() == "1 - cars"):
		textures = _load_car_textures()
	if(get_playing_card() == "2 - family"):
		textures = _load_family_textures()
	if(get_playing_card() == "3 - frozen"):
		textures = _load_frozen_textures()
	if(get_playing_card() == "4 - mermaid"):
		textures = _load_mermaid_textures()
	if(get_playing_card() == "5 - sofia"):
		textures = _load_sofia_textures()
	if(get_playing_card() == "6 - dora"):
		textures = _load_dora_textures()
	if(get_playing_card() == "7 - mickey"):
		textures = _load_mickey_textures()
	if(get_playing_card() == "8 - Paw Patrol"):
		textures = _load_paw_textures()		
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

func _load_mermaid_textures():
	var textures = {}
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = [
		load("res://sprites/mermaid/mermaid1.png"),
		load("res://sprites/mermaid/mermaid2.png"),
		load("res://sprites/mermaid/mermaid3.png"),
		load("res://sprites/mermaid/mermaid4.png"),
		load("res://sprites/mermaid/mermaid5.png"),
		load("res://sprites/mermaid/mermaid6.png")
	]
	return textures	

func _load_frozen_textures():
	var textures = {}
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = [
		load("res://sprites/frozen/anna.png"),
		load("res://sprites/frozen/elsa.png"),
		load("res://sprites/frozen/hans.png"),
		load("res://sprites/frozen/kristoff.png"),
		load("res://sprites/frozen/olaf.png"),
		load("res://sprites/frozen/sven.png")
	]
	return textures	

func _load_dora_textures():
	var textures = {}
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = [
		load("res://sprites/dora/dora1.png"),
		load("res://sprites/dora/dora2.png"),
		load("res://sprites/dora/dora3.png"),
		load("res://sprites/dora/dora4.png"),
		load("res://sprites/dora/dora5.png"),
		load("res://sprites/dora/dora6.png")
	]
	return textures	
	
func _load_sofia_textures():
	var textures = {}
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = [
		load("res://sprites/sofia/amber.png"),
		load("res://sprites/sofia/bailywick.png"),
		load("res://sprites/sofia/jade.png"),
		load("res://sprites/sofia/james.png"),
		load("res://sprites/sofia/ruby.png"),
		load("res://sprites/sofia/sofia.png")
	]
	return textures
	
	
func _load_mickey_textures():
	var textures = {}
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = [
		load("res://sprites/mickey/mickey1.png"),
		load("res://sprites/mickey/mickey2.png"),
		load("res://sprites/mickey/mickey3.png"),
		load("res://sprites/mickey/mickey4.png"),
		load("res://sprites/mickey/mickey5.png"),
		load("res://sprites/mickey/mickey6.png")
	]
	return textures
	
func _load_paw_textures():
	var textures = {}
	var textures_names = []
	for i in range(1, 14):
		textures_names.append("res://sprites/pawpatrol/paw" + str(i) + ".png")
	textures["hidden"] = load("res://sprites/card-background.png")
	textures["possible"] = []
	for file in textures_names:
		textures["possible"].append(load(file))

	return textures	