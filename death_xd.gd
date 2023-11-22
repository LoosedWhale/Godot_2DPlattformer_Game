extends Node2D

func _ready():
	$Options/Play_button.grab_focus()



func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://world.tscn")
	Game.playerHP = 10
	Game.Coins = 0
	Utils.saveGame()


func _on_full_screen_button_pressed():
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	elif DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)


func _on_quit_button_pressed():
	get_tree().quit()
