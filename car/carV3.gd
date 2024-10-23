extends VehicleBody3D

func _ready() -> void:
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

func _physics_process(delta: float) -> void:
	steering = lerp(steering,Input.get_axis("ui_right","ui_left") * 0.4, delta )
	var acceleration = Input.get_axis("ui_down","ui_up") 
	var rpm = $back_left.get_rpm()
	$back_left.engine_force =  acceleration * max_torque*(1- rpm / max_rpm)
	rpm =$back_right.get_rpm()
	$back_right.engine_force =  acceleration * max_torque*(1- rpm / max_rpm)
	#GlobalVariable.player_scores["tzz"] +=0.01
	#print(GlobalVariable.player_scores["tzz"]) 
