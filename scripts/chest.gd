extends Area2D
var target = null

func collect():
	if target is Hero:
		$AnimationPlayer.play("open")
		await $AnimationPlayer.animation_finished
		item()
		queue_free()

func item():
	target.control.sort_item()

func _process(delta):
	global_position = Vector2(199,-234)
