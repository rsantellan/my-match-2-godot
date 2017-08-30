# script: stage_manager.gd
extends CanvasLayer

const STAGE_GAME = "res://stages/cards_stage.tscn"
const STAGE_MENU = "res://stages/menu_stage.tscn"

var is_changing = false
signal stage_changed


func _ready():
	get_node("text_black").set_pos(Vector2(Globals.get("display/width"), Globals.get("display/height")))
	pass

func change_stage(stage_path):
	if is_changing:
		return
	is_changing = true
	get_tree().get_root().set_disable_input(true);
	# fade to black
	get_node("anim").play("fade_in")
	#audio_player.play("sfx_swooshing")
	yield(get_node("anim"), "finished")
	# change stage
	get_tree().change_scene(stage_path)
	emit_signal("stage_changed")
	# fade from black
	get_node("anim").play("fade_out")
	yield(get_node("anim"), "finished")
	is_changing = false
	get_tree().get_root().set_disable_input(false);
	pass
