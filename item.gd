extends Area2D
class_name moveable
var animation_speed = 2
var moving = false
var tile_size = 128
var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}
var tag = "item1"

@onready var ray = $RayCast2D

func _ready():
	#position = position.snapped(Vector2.ONE * tile_size)
	#position += Vector2.ONE * tile_size / 2
	pass
func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		#position += inputs[dir] * tile_size
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position + inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		#$AnimationPlayer.play(dir)
		await tween.finished
		moving = false
		


func _on_area_entered(area: Area2D) -> void:
	#if area is moveable
	pass
