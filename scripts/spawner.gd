# script (spawner.gd)

extends Timer

var spawn_items = [
	preload("res://scenes/enemy.tscn"),
	preload("res://scenes/barrel.tscn"),
	preload("res://scenes/roadblock.tscn")
]

func _ready():
	connect("timeout", self, "_on_timeout")
	pass
	
func _on_timeout():
	var item = spawn_items[0].instance()
	var r = rand_range(0, 500)
	item.set_pos(Vector2(r, -100))
	utils.get_main_node().add_child(item)
	pass
