extends Area3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	rotate_y(0.09)
	if has_overlapping_bodies():
		var label =$"../Label"  # Récupérer le Label
		
		GlobalVariable.current_player_score = GlobalVariable.current_player_score+1
		#GlobalVariable.player_scores[GlobalVariable.current_player_name] = GlobalVariable.player_scores[GlobalVariable.current_player_name] +1
		label.text = "Score : "+ str(GlobalVariable.current_player_score)  # Changer le texte
		queue_free()
	
	
