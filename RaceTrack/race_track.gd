extends Node3D

# Référence au Label pour afficher le nom du joueur
onready var player_name_label: Label = $Label2

# Liste des noms de joueurs (récupérés depuis le dictionnaire)


# Index du joueur actuel
var current_player_index: int = 0

# Fonction appelée au démarrage
func _ready():
	# Affiche le nom du premier joueur
	update_player_name()

# Fonction pour passer au joueur suivant
func next_player():
	current_player_index += 1
	if current_player_index >= player_names.size():
		current_player_index = 0
	update_player_name()

# Fonction pour afficher le nom du joueur actuel dans le Label
func update_player_name():
	var current_player_name = player_names[current_player_index]
	player_name_label.text = "Joueur actuel : " + current_player_name

# Fonction pour mettre à jour le score du joueur actuel
func update_player_score(new_score: int):
	var current_player_name = player_names[current_player_index]
	
	# Récupération du dictionnaire des scores depuis GlobalVariable
	var player_scores = GlobalVariable.get_player_scores()
	
	# Mise à jour du score du joueur actuel
	player_scores[current_player_name] = new_score
	
	# Met à jour les scores dans GlobalVariable (ajouter la fonction set_player_scores dans GlobalVariable)
	GlobalVariable.set_player_scores(player_scores)
	
	# Passe au joueur suivant
	next_player()
