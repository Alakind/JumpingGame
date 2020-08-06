extends TileMap


var button_area = preload("res://src/Objects/Interactable/ButtonArea.tscn")
var door = preload("res://src/Objects/Interactable/Door.tscn")
onready var mapscene_GUI = get_node("../GUI")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var used_tiles = get_used_cells_by_id(0)
	var delete_tiles = get_used_cells_by_id(1)
	
	for tile in used_tiles:
		var area_instance = button_area.instance()
		area_instance.position = map_to_world(tile)
		area_instance.tile = tile
		area_instance.tile_region = get_cell_autotile_coord(tile[0], tile[1])
		add_child(area_instance)
	
	for tile in delete_tiles:
		var area_instance = door.instance()
		area_instance.position = map_to_world(tile)
		area_instance.tile = tile
		area_instance.tile_region = get_cell_autotile_coord(tile[0], tile[1])
		add_child(area_instance)
	
	var tiles = get_tree().get_nodes_in_group("DoorArea")
	for area in get_tree().get_nodes_in_group("ButtonArea"):
		area.connect("body_entered", mapscene_GUI, "OnButtonAreaEntered", [tiles[0].tile, tiles[0].tile_region, tiles[0]])
		area.connect("body_exited", mapscene_GUI, "OnButtonAreaExited")

