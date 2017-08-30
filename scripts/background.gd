# script: background.gd
extends Sprite

var player = null

var _ypos = 0

func _ready():
	player = utils.get_main_node().get_node("player")
	print (player.speed)
	set_process(true)
	pass

func _process(delta):
	_ypos -= player.speed * delta
	set_region_rect(Rect2(0,_ypos,640,960))
	pass