extends Node


func _ready():
	$Buttons/LevelOne.grab_focus()

func _physics_process(delta):
	if $Buttons/LevelOne.is_hovered():
		$Buttons/LevelOne.grab_focus()
	if $Buttons/LevelTwo.is_hovered():
		$Buttons/LevelTwo.grab_focus()
	if $Buttons/LevelThree.is_hovered():
		$Buttons/LevelThree.grab_focus()


func _on_LevelOne_pressed() -> void:
	get_tree().change_scene("res://src/Levels/Level_1.tscn")


func _on_LevelTwo_pressed() -> void:
	get_tree().change_scene("res://src/Levels/Level_2.tscn")


func _on_LevelThree_pressed() -> void:
	get_tree().change_scene("res://src/Levels/Level_3.tscn")
