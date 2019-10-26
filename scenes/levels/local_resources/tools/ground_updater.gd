tool
extends TileMap

var time = 0

func _ready():
	if not Engine.editor_hint:
		set_process(false)

func _process(delta):
	if Engine.editor_hint:
		if time < 2000:
			time += 1
		else:
			print("Executing autotiling")
			time = 0
			update_tiles()

func update_tiles():
	var hidden_ground : TileMap = owner.get_node("HiddenLayer/Groundtiles")
	delete_cells(hidden_ground)
	var used_cells = get_used_cells()
	for cell in used_cells:
		var type = get_cell(cell.x, cell.y)
		var autotile_coord = get_cell_autotile_coord(cell.x, cell.y)
		hidden_ground.set_cell(cell.x, cell.y, type, false, false, false, autotile_coord)

func delete_cells(tilemap: TileMap):
	var used_cells = tilemap.get_used_cells()
	for cell in used_cells:
		tilemap.set_cellv(cell, -1)