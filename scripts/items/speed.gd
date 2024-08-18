extends Node2D
@onready var hero = Global.hero
@onready var duration_timer = $DurationTimer

var name_item = "Potion of Speed"
var cooldown = 11
var duration = 10
var moldure: Node
var quantity = 0
var eliminate = false

func use_item():
	if quantity <= 0 or moldure.item_actived == true:
		return

	moldure.item_actived = true
	Global.hero._speed += Global.hero.speed_base * 0.5
	duration_timer.start(duration)

	quantity -= 1
	moldure.update_carac(quantity)
	if quantity <= 0:
		eliminate = true

	await duration_timer.timeout
	Global.hero._speed -= Global.hero.speed_base * 0.5
	moldure.item_actived = false
	
	if eliminate == true:
		moldure.reset_moldure()
		queue_free()
