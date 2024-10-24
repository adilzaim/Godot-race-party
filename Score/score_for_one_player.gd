extends Control

# Variables pour stocker les infos du joueur actuel
var player_name: String
var player_score: int

# Fonction appelée lorsque la scène est prête
func _ready() -> void:
	# Charger les informations du joueur depuis GlobalVariable
	player_name = GlobalVariable.current_player_name
	player_score = GlobalVariable.current_player_score
	
	# Afficher le nom et le score du joueur
	$Label.text = "Player: " + player_name
	$Label2.text = "Score: " + str(player_score)
	
	# Vérifier s'il reste d'autres joueurs à jouer
	var has_next_player = check_if_more_players()
	
	
	
	# Si aucun joueur n'est disponible, on change le texte du bouton
	if not has_next_player:
		$Button.text = "Show Scoreboard"

# Vérifier s'il reste des joueurs à jouer
func check_if_more_players() -> bool:
	# Vérifier s'il reste un joueur qui n'a pas encore joué
	for player in GlobalVariable.player_scores.keys():
		if GlobalVariable.already_play[player] == 0:
			return true
	return false

# Gestion du bouton pour passer à la prochaine action
func _on_button_pressed() -> void:
	if check_if_more_players():
		# Si un autre joueur doit encore jouer, retourne à la scène du jeu
		get_tree().change_scene_to_file("res://RaceTrack/race_track.tscn")
	else:
		# Sinon, montre le tableau des scores
		get_tree().change_scene_to_file("res://Score/load_board.tscn")
