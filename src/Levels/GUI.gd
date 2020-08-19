extends CanvasLayer

var action_state = "Off"
var tile
var tile_region
var button_area



func _process(delta: float) -> void:
	match action_state:
		"Off":
			pass
		"Press":
			get_node("../Interactables").set_cell(tile[0], tile[1], 0, true, false, false, tile_region)
			get_node(str(button_area.get_path()) + "/CollisionShape2D").set_deferred("disabled", true)
	
func OnButtonAreaEntered(body, tile_import, tile_region_import, area_import_door):
	if body.is_in_group("player"):
		print("pressed")
		action_state = "Press"
		tile = tile_import
		tile_region = tile_region_import + Vector2(0, 1)
		button_area = area_import_door
		
func OnButtonAreaExited(body):
	print("out")
