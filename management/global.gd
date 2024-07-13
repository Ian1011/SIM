extends Node
class_name global

# Variables
var game: Game
var hero: Hero
var paused_available = true
var difficulty_tax: float 
var level: int
var timer_counter: String

func game_over():
	level = hero._level
	timer_counter = hero.control.timer_counter.text
	get_tree().change_scene_to_file("res://scenes/menus/game_over.tscn")
