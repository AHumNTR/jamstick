extends Area2D
class_name  player
@export var reversed=false
var animation_speed = 2

var moving = false
var tile_size = 128
var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}
var current_level
@onready var ray = $RayCast2D
@onready var tilemap_layer =   get_node("../TileMapLayer")

func _ready():
	current_level = get_parent().name
	if reversed:
		$Sprite2D.modulate = Color.RED
	#position = position.snapped(Vector2.ONE * tile_size)
	#position += Vector2.ONE * tile_size / 2
	pass

func _unhandled_input(event):
	if moving:
		return
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)
			
func move(dir):
	ray.target_position = inputs[dir] * tile_size*(-1 if reversed else 1)
	ray.force_raycast_update()
	if !ray.is_colliding():
		#position += inputs[dir] * tile_size
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position + inputs[dir]*(-1 if reversed else 1) * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		#$AnimationPlayer.play(dir)
		await tween.finished
		moving = false
		var tile_pos = tilemap_layer.local_to_map(global_position)
		var tile_data = tilemap_layer.get_cell_tile_data(tile_pos)
		if tile_data == null:
			get_tree().reload_current_scene()
		
	elif ray.get_collider() is moveable:
		ray.get_collider().move(inputs[dir]*(-1 if reversed else 1))
	elif ray.get_collider() is player:
		get_tree().change_scene_to_file("res://scenes/"+ str(int(current_level)+1) +".tscn")

#sonra sorun çıkarabilir
func _on_area_entered(area: Area2D) -> void:
	if area is player:
		get_tree().change_scene_to_file("res://scenes/"+ str(int(current_level)+1) +".tscn")
