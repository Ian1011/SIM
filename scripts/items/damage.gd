extends Node2D
@onready var hero = Global.hero
@onready var duration_timer = $DurationTimer

var name_item = "Potion of Strength"
var cooldown = 6
var duration = 5
var moldure: Node
var quantity = 0
var eliminate = false

func use_item():
	if quantity <= 0 or moldure.item_actived == true:
		return

	moldure.item_actived = true
	Global.hero.buff_attack += 0.2
	duration_timer.start(duration)

	quantity -= 1
	moldure.update_carac(quantity)
	if quantity <= 0:
		eliminate = true

	await duration_timer.timeout
	Global.hero.buff_attack -= 0.2
	moldure.item_actived = false
	
	if eliminate == true:
		moldure.reset_moldure()
		queue_free()
