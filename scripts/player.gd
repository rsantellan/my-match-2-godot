# script: player.gd
extends RigidBody2D

var speed = 0
var _max_speed = 500
var _acceleration = 0

func _ready():
	self.set_fixed_process(true)
	pass

func _fixed_process(delta):
	speed += _acceleration
	speed = min(speed, _max_speed)
	if(speed < _max_speed):
		_acceleration += delta
	pass
