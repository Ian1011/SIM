extends Control


#conectar com botão jogar, tem que muda "res://cena_1.tscn" para uma cena que-
#tenha ai no seu comando
func _on_jogar_bt_pressed():
	get_tree().change_scene_to_file("res://cena_1.tscn")

#aqui eu queria pasa para uma tela que tenha nossa logo e alguns eggs futuros :}
func _on_sim_bt_pressed():
	pass # Replace with function body.


func _on_sair_bt_pressed():
	get_tree().quit()
