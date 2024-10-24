extends Control

var player_scores=GlobalVariable.player_scores  # Dictionnaire pour associer chaque joueur à un score.

# Appelé lors de l'entrée du nœud dans la scène.
func _ready() -> void:
	player_scores = {}  # Initialisation du dictionnaire vide.

# Appelé lorsque le bouton est pressé.
func _on_button_pressed() -> void:
	print("Button go pressed")
	print(GlobalVariable.player_scores)
	# Pour chaque joueur dans le dictionnaire, poster un score
	
	# Une fois tous les scores postés, changer de scène.
	get_tree().change_scene_to_file("res://RaceTrack/race_track.tscn")

# Fonction appelée lorsque du texte est soumis dans le LineEdit.
func _on_line_edit_text_submitted(new_text: String) -> void:
	# Vérifier si le texte contient des virgules.
	if new_text.find(",") != -1:  # Utilisation de find() pour vérifier la présence d'une virgule.
		# Séparer les noms par des virgules et nettoyer les espaces.
		var player_names = new_text.split(",")
		
		# Nettoyer et valider chaque nom.
		var valid_players = []
		for name in player_names:
			var cleaned_name = name.strip_edges()
			if cleaned_name != "":
				valid_players.append(cleaned_name)  # Ajouter les noms valides à la liste.

		# Vérifier qu'il y a des joueurs valides à ajouter.
		if valid_players.size() > 0:
			GlobalVariable.player_scores.clear()  # Effacer les anciens scores.
			for player_name in valid_players:
				GlobalVariable.player_scores[player_name] = 0  # Enregistrer chaque joueur avec un score de 0.
			print("Players added: %s" % [valid_players])
		else:
			print("Aucun nom valide fourni.")
	else:
		# Si un seul joueur est fourni sans virgule.
		var single_player_name = new_text.strip_edges()
		if single_player_name != "":
			GlobalVariable.player_scores.clear()  # Effacer les anciens scores.
			GlobalVariable.player_scores[single_player_name] = 0  # Enregistrer le nouveau joueur avec un score de 0.
			print("Player added: %s, Score: %d" % [single_player_name, GlobalVariable.player_scores[single_player_name]])
		else:
			print("Aucun nom valide fourni.")
	GlobalVariable.already_play = GlobalVariable.player_scores;
	# Afficher les scores des joueurs pour vérification.
	print(GlobalVariable.player_scores)
