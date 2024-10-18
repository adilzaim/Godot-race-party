# Jeu de Course Multijoueur en Local avec Godot

Ce projet consiste en un jeu de course multijoueur local développé avec le moteur Godot. Les joueurs jouent chacun leur tour sur le même écran, contrôlant une voiture qui doit parcourir une piste, accumuler des points en touchant des bonus, et atteindre la ligne d'arrivée le plus rapidement possible. À la fin du jeu, les résultats sont affichés et les joueurs sont classés en fonction de leur temps.

## Fonctionnalités

- Inscription des joueurs avec leurs noms.
- Jeu multijoueur au tour par tour sur le même écran.
- Accumulation de points en touchant des bonus.
- Chronomètre qui mesure le temps écoulé depuis le départ jusqu'à l'arrivée.
- Classement des joueurs par ordre croissant de temps et indication du gagnant.

## Étapes d'Implémentation

### Étape 1 : Configuration de Base du Projet

1. **Créer un nouveau projet Godot** :
   - Initialise un projet en 3D pour profiter des fonctionnalités de simulation physique.

2. **Configurer les scènes de base** :
   - Crée une scène pour l'écran de démarrage (`MainMenu.tscn`), où les joueurs pourront entrer leurs noms.
   - Crée une scène pour représenter une voiture (`Car.tscn`), avec des noeuds pour les roues et le corps.
   - Crée une scène pour la piste de course (`RaceTrack.tscn`) avec un sol, des obstacles et des bonus.
   - Crée une scène pour l'affichage des résultats (`Results.tscn`).
   - Crée la scène principale qui charge les autres scènes.

### Étape 2 : Système d'Inscription des Joueurs

1. **Créer une interface utilisateur pour l'inscription** :
   - Dans `MainMenu.tscn`, ajoute une `LineEdit` pour que chaque joueur entre son nom, et un bouton "Jouer" pour commencer.

2. **Stocker les informations des joueurs** :
   - Utilise un `Array` pour stocker les informations des joueurs, incluant le nom et le score.

### Étape 3 : Mise en Place de la Piste de Course

1. **Créer la scène de la piste de course** :
   - Dans `RaceTrack.tscn`, ajoute un `StaticBody3D` pour la piste, afin de créer une surface sur laquelle les voitures roulent.
   - Place les obstacles, virages et bonus (`Area3D`) sur la piste.

2. **Configurer les voitures** :
   - Crée une scène de voiture (`RigidBody3D`) avec un script pour gérer les contrôles.
   - Instancie une voiture pour chaque joueur sur la ligne de départ.

### Étape 4 : Contrôles et Physique des Voitures

1. **Implémenter les contrôles des voitures** :
   - Ajoute un script pour gérer l'accélération, le freinage, et les virages des voitures.

2. **Gérer les collisions avec les bonus** :
   - Utilise `Area3D` pour détecter les collisions entre les voitures et les objets de bonus.
   - Incrémente le score du joueur chaque fois qu'une collision avec un bonus est détectée.

### Étape 5 : Ajouter le Chronomètre

1. **Créer un chronomètre** :
   - Utilise un `Timer` pour mesurer le temps écoulé depuis le départ.
   - Affiche le temps écoulé à l'écran pour que les joueurs puissent le voir.

2. **Arrêter le chronomètre à l'arrivée** :
   - Détecte quand une voiture atteint la ligne d'arrivée et enregistre le temps pour ce joueur.

### Étape 6 : Gestion des Scores et Affichage des Résultats

1. **Classer les joueurs par temps** :
   - Une fois que tous les joueurs ont terminé, trie-les en fonction de leur temps.

2. **Afficher les résultats finaux** :
   - Crée une scène pour montrer la liste des joueurs en ordre croissant de temps.
   - Indique le gagnant (le joueur avec le temps le plus bas).

### Étape 7 : Gestion des Tours des Joueurs

#### Étape 7.1 : Création de la Liste des Joueurs

1. **Stocker les informations des joueurs dans un `Array`** :
   - Inclut le nom du joueur, le score et le temps total.

2. **Utiliser un index (`current_player_index`) pour garder la trace du joueur en cours** :
   - Lorsqu'un joueur termine son tour, l'index est incrémenté pour passer au joueur suivant.

#### Étape 7.2 : Passer au Joueur Suivant

1. **Changer de joueur après la fin du tour** :
   - Incrémente l'index pour passer au joueur suivant.

2. **Réinitialiser la position de la voiture et le chronomètre** :
   - Replace la voiture à la ligne de départ et réinitialise les paramètres (vitesse, score, etc.).

#### Étape 7.3 : Afficher les Scores Intermédiaires

1. **Afficher les résultats actuels entre chaque tour** :
   - Affiche les scores et les temps enregistrés jusqu'à présent.

#### Étape 7.4 : Classement Final après Tous les Tours

1. **Classement des joueurs par temps total** :
   - Trie les joueurs selon le temps total pour chaque course.

2. **Affichage de la liste des résultats finaux avec le gagnant indiqué**.

## Exemple de Script pour les Voitures

```gdscript
extends RigidBody3D

var acceleration = 10.0
var max_speed = 50.0
var current_speed = 0.0

func avancer(delta: float) -> void:
    current_speed += acceleration * delta
    if current_speed > max_speed:
        current_speed = max_speed
    var forward_force = transform.basis.z.normalized() * -current_speed
    apply_central_force(forward_force)

func reculer(delta: float) -> void:
    current_speed -= acceleration * delta
    if current_speed < -max_speed:
        current_speed = -max_speed
    var backward_force = transform.basis.z.normalized() * -current_speed
    apply_central_force(backward_force)

func _physics_process(delta: float) -> void:
    if Input.is_action_pressed("ui_up"):
        avancer(delta)
    elif Input.is_action_pressed("ui_down"):
        reculer(delta)
    else:
        current_speed *= 0.98
