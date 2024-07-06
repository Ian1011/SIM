extends Control

@export_category('Objects')
var game_over_label
var stats_label
var image

var level = Global.level
var timer_counter = Global.timer_counter
var speed = 100

func _ready():
	game_over_label = $GameOver
	stats_label = $StatsLabel
	image = $Image
	var screen_size = get_viewport_rect().size
	game_over_label.position = Vector2(game_over_label.position.x, (screen_size.y - game_over_label.position.y) / 2)
	stats_label.visible = false

func _process(delta):
	if game_over_label.position.y > 0:
		game_over_label.position.y -= speed * delta
	else:
		game_over_label.position.y = 0
		stats_label.position = Vector2(stats_label.position.x, game_over_label.position.y + game_over_label.size.y + 10)
		stats_label.text = str("Level: ", level, "\nTempo: ", timer_counter, "\nPressione Enter para continuar")
		stats_label.visible = true
		image.visible = true
		
	if stats_label.visible:
		if Input.is_action_pressed("ui_accept"):
				get_tree().change_scene_to_file("res://scenes/menus/menu.tscn")

