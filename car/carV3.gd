extends VehicleBody3D

func _ready() -> void:
	
	GlobalVariable.current_player_score = 0
	# Vérifier que le singleton est accessible
	if GlobalVariable.player_scores:
		print("Player scores are accessible!")
		print(GlobalVariable.player_scores)
		#add_player_score("Player4444", 5454)
		#print(GlobalVariable.player_scores)
	else:
		print("Unable to access player scores.")



		
var max_rpm = 500
var max_torque = 200
var score = 0
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D

func _physics_process(delta: float) -> void:
	steering = lerp(steering, Input.get_axis("ui_right", "ui_left") * 0.4, delta)
	var acceleration = Input.get_axis("ui_down", "ui_up")
	var rpm_left = $back_left.get_rpm()
	var rpm_right = $back_right.get_rpm()
	
	$back_left.engine_force = acceleration * max_torque * (1 - rpm_left / max_rpm)
	$back_right.engine_force = acceleration * max_torque * (1 - rpm_right / max_rpm)
	
	# Si l'accélération est non nulle et le son n'est pas déjà joué, on le joue
	if acceleration != 0:
		if not audio_stream_player_3d.playing:
			audio_stream_player_3d.play()
		
		# Ajustez le pitch en fonction du régime moteur
		var avg_rpm = (rpm_left + rpm_right) / 2
		audio_stream_player_3d.pitch_scale = 1.0 + (avg_rpm / max_rpm) * 0.5  # Ajustez ce facteur pour varier la hauteur
	else:
		# Arrête le son si l'accélération est à zéro
		audio_stream_player_3d.stop()



		
		
