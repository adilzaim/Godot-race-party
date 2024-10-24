extends Node3D

# Liste des noms de joueurs (récupérés depuis le dictionnaire)
var player_names: Array = GlobalVariable.get_player_scores().keys()

# Index du joueur actuel
var current_player_index: int = 0

var timer = 10  # Le temps pour chaque partie (en secondes)

# Fonction appelée quand le node est prêt
func _ready() -> void:
	# Trouver le premier joueur qui n'a pas encore joué
	find_next_available_player()
	update_player_name()

# Fonction pour trouver le prochain joueur disponible qui n'a pas encore joué
func find_next_available_player() -> void:
	# Chercher un joueur qui n'a pas encore joué
	while GlobalVariable.already_play[player_names[current_player_index]] == 1:
		current_player_index += 1
		if current_player_index >= player_names.size():
			# Si on atteint la fin de la liste des joueurs, tous les joueurs ont joué
			current_player_index = 0  # Réinitialiser l'index pour éviter un dépassement
			break

# Fonction pour passer au joueur suivant
func next_player():
	current_player_index += 1
	
	# Si on atteint la fin de la liste, on revient au début
	if current_player_index >= player_names.size():
		current_player_index = 0
	
	# Chercher un joueur qui n'a pas encore joué
	find_next_available_player()
	
	# Mettre à jour l'interface avec le nom du joueur actuel
	update_player_name()

# Fonction pour afficher le nom du joueur actuel dans le Label
func update_player_name():
	var current_player_name = player_names[current_player_index]
	$Label2.text = "Player : " + current_player_name

# Fonction pour mettre à jour le score du joueur actuel
func update_player_score(new_score: int):
	var current_player_name = player_names[current_player_index]
	
	# Mettre à jour le score du joueur actuel dans GlobalVariable
	GlobalVariable.player_scores[current_player_name] = new_score
	
	# Marquer le joueur comme ayant joué
	GlobalVariable.already_play[current_player_name] = 1
	
	# Stocker le score et le nom dans GlobalVariable pour utilisation future
	GlobalVariable.current_player_name = current_player_name
	
	
	# Passer au joueur suivant
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
	# Vérifier et récupérer le nom et le score du joueur actuel
	var current_player_name = player_names[current_player_index]
	var current_player_score = GlobalVariable.player_scores[current_player_name]
	
	# Stocker le nom et le score dans les variables globales (important)
	GlobalVariable.current_player_name = current_player_name
	
	
	# Marquer le joueur comme ayant joué (évite qu'il rejoue)
	GlobalVariable.already_play[current_player_name] = 1
	
	# Debugging pour vérifier que le score est bien mis à jour
	print("Player: ", current_player_name, " Score: ", current_player_score)
	
	# Changer de scène pour afficher le score du joueur actuel
	get_tree().change_scene_to_file("res://Score/ScoreForOnePlayer.tscn")

# Vérifier s'il reste des joueurs qui n'ont pas encore joué
func check_if_more_players() -> bool:
	for player in player_names:
		if GlobalVariable.already_play[player] == 0:
			return true  # Il reste des joueurs
	return false  # Tous les joueurs ont joué
