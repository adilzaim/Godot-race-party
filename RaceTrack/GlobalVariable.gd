extends Node

var player_scores: Dictionary = {
	"tzz": 0,
	"Player2": 0,
	"Player3": 0
}

var already_play: Dictionary = {
	"tzz": 0,
	"Player2": 0,
	"Player3": 0
}

#curent player and his score
var current_player_name: String = ""
var current_player_score: int = 0

# Fonction pour récupérer les scores
func get_player_scores() -> Dictionary:
	return player_scores
