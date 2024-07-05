extends Control
#conectar com botão jogar, tem que muda "res://cena_1.tscn" para uma cena que-
#tenha ai no seu comando

func _on_jogar_bt_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

#aqui eu queria pasa para uma tela que tenha nossa logo e alguns eggs futuros :}
func _on_sim_bt_pressed():
	var music = self.get_children()
	print(music)


func _on_sair_bt_pressed():
	get_tree().quit()

func _on_music_finished():
	var music = self.get_children()
	music[2].play()
