extends Node3D

# Liste des noms de joueurs (récupérés depuis le dictionnaire)
var player_names: Array = GlobalVariable.get_player_scores().keys()

# Index du joueur actuel
var current_player_index: int = 0

var timer = 10  # Le temps pour chaque partie (en secondes)

# Fonction pour passer au joueur suivant
func next_player():
	current_player_index += 1
	
	# Si on atteint la fin de la liste, on revient au début
	if current_player_index >= player_names.size():
		current_player_index = 0
	
	# Boucle jusqu'à trouver un joueur qui n'a pas encore joué
	while GlobalVariable.already_play[player_names[current_player_index]] == 1:
		current_player_index += 1
		if current_player_index >= player_names.size():
			current_player_index = 0
	
	# Mettre à jour l'interface avec le nom du joueur actuel
	update_player_name()

# Fonction pour afficher le nom du joueur actuel dans le Label
func update_player_name():
	var current_player_name = player_names[current_player_index]
	$Label2.text = "Player : " + current_player_name

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_player_name()

# Fonction pour mettre à jour le score du joueur actuel
func update_player_score(new_score: int):
	var current_player_name = player_names[current_player_index]
	GlobalVariable.player_scores[current_player_name] = new_score
	next_player()

# Fonction appelée à chaque frame
func _process(delta: float) -> void:
	# Réduire le temps restant en fonction de delta (le temps écoulé depuis la dernière frame)
	timer -= delta
	
	# Mettre à jour l'affichage du timer
	$Label3.text = "Temps restant : " + str(int(timer)) + "s"
	
	# Vérifier si le timer est écoulé
	if timer <= 0:
		end_game()

# Fonction pour terminer la partie du joueur actuel et changer de scène
func end_game():
	var current_player_name = player_names[current_player_index]
	var current_player_score = GlobalVariable.player_scores[current_player_name]
	
	# Stocker le nom et le score dans les variables globales
	GlobalVariable.current_player_name = current_player_name
	GlobalVariable.current_player_score = current_player_score
	
	# Marquer le joueur comme ayant joué
	GlobalVariable.already_play[current_player_name] = 1
	
	# Vérifier s'il reste des joueurs qui n'ont pas encore joué
	if check_if_more_players():
		# Changer de scène pour afficher le score du joueur actuel
		get_tree().change_scene_to_file("res://Score/ScoreForOnePlayer.tscn")
	else:
		# Si tous les joueurs ont joué, aller directement au tableau des scores final
		get_tree().change_scene_to_file("res://Score/ScoreBoard.tscn")

# Vérifier s'il reste des joueurs qui n'ont pas encore joué
func check_if_more_players() -> bool:
	for player in player_names:
		if GlobalVariable.already_play[player] == 0:
			return true  # Il reste des joueurs
	return false  # Tous les joueurs ont joué
