# scripts: utils.gd
extends Node

func _ready():
	pass

func get_main_node():
	var root_node = self.get_tree().get_root()
	return root_node.get_child(root_node.get_child_count() - 1)
	
	
func get_digits(number):
	# get the current score in a string
	var strn_number = str(number)
	var digits = []

	# loop the string and append each char as an int
	for i in range(strn_number.length()): 
		digits.append(strn_number[i].to_int())
	return digits