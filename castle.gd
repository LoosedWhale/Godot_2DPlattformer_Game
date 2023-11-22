extends Node2D

func _on_door_player_entered(level):
	get_tree().change_scene_to_file(level)
