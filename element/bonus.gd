extends MeshInstance3D

# Appelé lorsque le noeud entre dans la scène pour la première fois
func _ready() -> void:
	# Vérifier si le noeud `Area3D` est présent et se connecter au signal `area_entered`
	if has_node("Area3D"):
		var area = $Area3D
		# Connexion en utilisant Callable pour appeler `_on_area_3d_area_entered`
		area.connect("area_entered", Callable(self, "_on_area_3d_area_entered"))

# Appelé à chaque frame. "delta" est le temps écoulé depuis le frame précédent
func _process(delta: float) -> void:
	rotate_y(0.09)  # Fait tourner le bonus

# Fonction appelée lorsque la collision avec le bonus est détectée
func _on_area_3d_area_entered(area: Area3D) -> void:
	print("bonus collision")
	# Supprime le bonus lorsqu'une collision est détectée
	queue_free()
