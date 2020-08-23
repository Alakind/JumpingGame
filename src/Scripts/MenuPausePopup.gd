extends Popup

onready var player = get_node("/root/Root/Player")
var already_paused
var selected_menu

func _ready():
	player = get_node("/root/Root/Player")
	
func change_menu_color():
	$Resume.color = Color.gray
	$Restart.color = Color.gray
	$Quit.color = Color.gray
	
	match selected_menu:
		0:
			$Resume.color = Color.greenyellow
		1:
			$Restart.color = Color.greenyellow
		2:
			$Quit.color = Color.greenyellow


func _input(event: InputEvent) -> void:
	if not visible:
		pass
	else:
		pass
