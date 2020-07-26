extends Sprite

func _on_Area2D_area_entered(area):
	if area.is_in_group("player"):
		get_tree().change_scene("res://src/Levels/Level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn")


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		
		get_tree().change_scene("res://src/Levels/Level_" + str(int(get_tree().current_scene.name) + 1) + ".tscn")
