extends Node


func _ready():
	$Buttons/PlayButton.grab_focus()

func _physics_process(delta):
	if $Buttons/PlayButton.is_hovered():
		$Buttons/PlayButton.grab_focus()
	if $Buttons/LevelsButton.is_hovered():
		$Buttons/LevelsButton.grab_focus()
	if $Buttons/OptionsButton.is_hovered():
		$Buttons/OptionsButton.grab_focus()


func _on_PlayButton_pressed():
	get_tree().change_scene("res://src/Levels/Level_1.tscn")


func _on_LevelsButton_pressed() -> void:
	get_tree().change_scene("res://src/Menu/LevelSelect.tscn")


func _on_OptionsButton_pressed() -> void:
	get_tree().change_scene("res://src/Menu/SettingsMenu.tscn")
