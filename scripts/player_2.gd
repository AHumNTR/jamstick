extends Area2D

var animation_speed = 2
var moving = false
var tile_size = 128
var mirror_inputs = {
	"left": Vector2.RIGHT,
	"right": Vector2.LEFT,
	"down": Vector2.UP,
	"up": Vector2.DOWN
}
var mirror = {
	"right": "left",
	"left": "right",
	"up": "down",
	"down": "up"
}


@onready var ray = $RayCast2D

func _ready():
	#position = position.snapped(Vector2.ONE * tile_size)
	#position += Vector2.ONE * tile_size / 2
	pass
	
func _unhandled_input(event):
	if moving:
		return
	for dir in mirror_inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)
			
func move(dir):
	ray.target_position = mirror_inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		#position += inputs[dir] * tile_size
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position + mirror_inputs[dir] * tile_size, 1.0/animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		#$AnimationPlayer.play(dir)
		await tween.finished
		moving = false
	elif ray.get_collider() is moveable:
		ray.get_collider().move(mirror[dir])
		print(dir)
