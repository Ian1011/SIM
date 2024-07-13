extends CanvasLayer

@onready var resume_bt = $MenuHolder/ResumeBt
var are_you_sure = false

func _ready():
	visible = false
	

func _process(delta):
	pass
	

func _unhandled_input(event):
	if Global.paused_available:
		if event.is_action_pressed("ui_cancel"):
			help_function()
			resume_bt.grab_focus()

func help_function():
	visible = !visible
	get_tree().paused = !get_tree().paused

func _on_resume_bt_pressed():
	are_you_sure = false
	help_function()


func _on_inventário_bt_pressed():
	pass # Replace with function body.


func _on_sair_bt_pressed():
	if are_you_sure:
		get_tree().change_scene_to_file("res://scenes/menus/menu.tscn")
	are_you_sure = true
	$AreYouSure.visible = true

