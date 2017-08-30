# script: card.gd
extends Area2D

var isHidden = true
var hiddenTexture = "car.png"
var showTexture = "car1.png"

func _ready():
	set_process_input(true)
	pass

func _process(delta):
	pass
	
func _input(event):
	# if user left clicks
	if(event.type == InputEvent.MOUSE_BUTTON):
		if(event.button_index == BUTTON_LEFT and event.pressed):
			changeSprite()
	pass
	
func changeSprite():
	if (isHidden):
		print("showing")
		isHidden = !isHidden
		get_node("sprite").set_texture(load("res://sprites/"+showTexture))
	else:
		print("hiding")
		get_node("sprite").set_texture(load("res://sprites/"+hiddenTexture))
		isHidden = !isHidden
	pass
	
func get_width_size():
	return get_node("sprite").get_texture().get_width() # * get_node("sprite").get_scale()
	pass

func change_position(x, y):
	var pos = self.get_pos()
	pos.x = pos.x + x
	pos.y = pos.y + y
	self.set_pos(pos)
	pass