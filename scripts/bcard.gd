#script: bcard.gd
extends TextureButton

var isHidden = true
var hiddenTexture = "car.png"
var showTexture = "car1.png"

var _cardObj

func _ready():
	connect("pressed", self, "_on_pressed")
	pass

func set_card_obj(cardObj):
	self._cardObj = cardObj
	set_normal_texture(_cardObj.get_hidden_sprite())
	set_pressed_texture(_cardObj.get_showing_sprite())
	
func get_card_obj():
	return self._cardObj

func _on_pressed():
	_do_show_hide()
	pass

func _do_disable_card():
	set_disabled(true)
	pass

func _do_show_hide():
	if (isHidden):
		set_pressed(true)
		isHidden = !isHidden
		if _cardObj != null:
			set_normal_texture(_cardObj.get_showing_sprite())
			pass
		else:
			set_normal_texture(load("res://sprites/"+showTexture))
	else:
		set_pressed(false)
		if _cardObj != null:
			set_normal_texture(_cardObj.get_hidden_sprite())
			pass
		else:
			set_normal_texture(load("res://sprites/"+hiddenTexture))
		isHidden = !isHidden
		
func get_width_size():
	return get_normal_texture().get_width() # * get_node("sprite").get_scale()
	pass

func get_height_size():
	return get_normal_texture().get_height()
	pass
	
func change_position(x, y):
	var pos = self.get_pos()
	pos.x = pos.x + x
	pos.y = pos.y + y
	self.set_pos(pos)
	pass
