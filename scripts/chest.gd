extends Area2D
@onready var control = Global.hero.control
var target = null

func collect():
	if target is Hero:
		$AnimationPlayer.play("open")
		await $AnimationPlayer.animation_finished
		item()
		queue_free()

func item():
	control.sort_item()
