extends Node


func _ready():
	$MarginContainer/VBoxContainer/VBoxContainer/PlayButton.grab_focus()

func _physics_process(delta):
	if $MarginContainer/VBoxContainer/VBoxContainer/PlayButton.is_hovered():
		$MarginContainer/VBoxContainer/VBoxContainer/PlayButton.grab_focus()
	if $MarginContainer/VBoxContainer/VBoxContainer/LevelsButton.is_hovered():
		$MarginContainer/VBoxContainer/VBoxContainer/LevelsButton.grab_focus()


func _on_PlayButton_pressed():
	get_tree().change_scene("res://src/Levels/Level_1.tscn")
