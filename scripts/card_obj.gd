# script: card_obj.gd
extends Node

class CardObj:
	var _showing_sprite
	var _hidden_sprite
	var _identifier
	var _value
	var _marked = false

	func set_showing_sprite(sprite):
		self._showing_sprite = sprite
	
	func get_showing_sprite():
		return self._showing_sprite
		
	func set_hidden_sprite(sprite):
		self._hidden_sprite = sprite
	
	func get_hidden_sprite():
		return self._hidden_sprite

	func set_identifier(identifier):
		self._identifier = identifier
	
	func get_identifier():
		return self._identifier
		
	func set_value(value):
		self._value = value
	
	func get_value():
		return self._value

	func set_marked(marked):
		self._marked = marked
	
	func get_marked():
		return self._marked

	func compareTo(element):
		if (self.get_value() == element.get_value()):
			return true
		return false
	
	func compareIdentifier(element):
		if (self.get_identifier() == element.get_identifier()):
			return true
		return false