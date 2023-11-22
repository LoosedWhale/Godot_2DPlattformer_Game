extends Node2D

#func _on_door_body_entered(body):
	#if body == $Player/Player:
		
		#$DoorSfx.play()
		#get_tree().change_scene_to_file("res://castle.tscn")


func _on_door_player_entered(level):
	get_tree().change_scene_to_file(level)
