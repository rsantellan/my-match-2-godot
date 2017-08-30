# script (enemy.gd)
extends RigidBody2D

var _ypos = 0
var _player = null
var _speed_factor = 0.5

func _ready():
	show()
	_player = utils.get_main_node().get_node("player")
	print (_player)
	set_process(true)
	load_car_texture()
	pass
	
func _process(delta):
	#print (get_pos())
	self.set_pos(self.get_pos() + Vector2(0, _player.speed * _speed_factor * delta))
	
func load_car_texture():
	var number = randi()%6+1
	self.get_node("sprite").set_texture(load("res://sprites/car" + str(number) +".png"))
	
func set_rand_start_position():
	var curPos = self.get_pos()
	curPos.y = _ypos
	curPos.x = rand_range(self.get_item_rect().size.width / 2, self.get_viewport_rect().size.width - self.get_item_rect().size.width / 2)
	self.set_pos(curPos)