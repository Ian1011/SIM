extends Node2D
@onready var hero = Global.hero
@onready var invincibility_timer = $InvincibilityTimer
var name_item = "Potion of Invincibility"
var cooldown = 6
var duration = 5
var moldure: Node
var quantity = 0
var eliminate = false

func use_item():
	if quantity <= 0 or moldure.item_actived == true:
		return

	moldure.item_actived = true
	
	Global.hero.collision_area.set_deferred("disable", true)
	Global.hero.sprite.modulate = Color(1,1,1,0.4)
	invincibility_timer.start(duration)

	quantity -= 1
	moldure.update_carac(quantity)
	if quantity <= 0:
		eliminate = true

	await invincibility_timer.timeout
	Global.hero.collision_area.set_deferred("disable", false)
	Global.hero.sprite.modulate = Color(1,1,1,1)
	moldure.item_actived = false
	
	if eliminate == true:
		moldure.reset_moldure()
		queue_free()
