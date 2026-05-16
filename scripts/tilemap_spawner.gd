extends TileMapLayer


# Called when the node enters the scene tree for the first time.
@export var items: Array[PackedScene]
func _ready() -> void:
	for cell in get_used_cells():
		var source_id = get_cell_source_id(cell)
		if(source_id==2):
			var atlas_coords = get_cell_atlas_coords(cell)
			var item= items[source_id-2].instantiate() as moveable
			add_child(item)
			item.position=map_to_local(cell)
			item.typeIndex=atlas_coords.y
			var tileset_source: TileSetAtlasSource = tile_set.get_source(source_id) as TileSetAtlasSource
			var sprite=(item.get_node("Sprite2D") as Sprite2D)
			sprite.texture=tileset_source.texture
			sprite.region_enabled = true
			sprite.region_rect = tileset_source.get_tile_texture_region(atlas_coords)
			set_cell(cell,1,Vector2i(0,0))
		elif(source_id==3):
			var atlas_coords = get_cell_atlas_coords(cell)
			var item= items[source_id-2].instantiate() as moveable
			add_child(item)
			item.position=map_to_local(cell)
			item.typeIndex=atlas_coords.y
			var tileset_source: TileSetAtlasSource = tile_set.get_source(source_id) as TileSetAtlasSource
			var sprite=(item.get_node("Sprite2D") as Sprite2D)
			sprite.texture=tileset_source.texture
			sprite.region_enabled = true
			sprite.region_rect = tileset_source.get_tile_texture_region(atlas_coords)
			set_cell(cell,1,Vector2i(0,0))
