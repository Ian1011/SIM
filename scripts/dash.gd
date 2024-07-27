extends Node2D

@onready var ghost_scene = preload("res://scenes/items/dash_unit.tscn")
@onready var ghost_timer = $GhostTimer
var cooldown = 1
var quantity = 0

var hero

func _ready():
	pass

func _use_item():
	dash()

func add_ghost():
	var ghost = ghost_scene.instantiate()
	ghost.set_property(hero.position, hero.sprite.scale)
	ghost.texture = hero.sprite.texture
	ghost.flip_h = hero.sprite.flip_h
	add_child(ghost)

func dash():
	ghost_timer.start()
	
	var tween = get_tree().create_tween()
	var hero_velocity
	
	if hero.velocity == Vector2(0,0):
		hero_velocity = hero._look_direction * hero._speed
		print(hero._look_direction, hero._speed)
		print(hero_velocity)
	else:
		hero_velocity = hero.velocity

	tween.tween_property(hero, "position", hero.position + hero_velocity * 2, 0.38)
	print(hero.velocity)
	
	await tween.finished
	
	ghost_timer.stop()
	
func _input(event):
	if event.is_action_pressed("ui_home"):
		dash()

func _on_ghost_timer_timeout():
	add_ghost()
