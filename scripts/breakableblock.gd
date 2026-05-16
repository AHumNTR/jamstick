extends Area2D

var tileCell: Vector2i
var tileMap: TileMap
var isGonnaBreak=false

func _on_area_entered(area: Area2D) -> void:
	print("hello")
	isGonnaBreak=true

