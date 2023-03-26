extends Area

export (String, "bolt", "ammo") var type

# var position 			   = Vector3()
var timer 				   = Timer.new()

var active 				   = false
var getMagnet 			   = false
var random 	  			   = RandomNumberGenerator.new() # Adding random number.
var collectible_image_path = "res://resources/images/collectibles/"

# Called when the node enters the scene tree for the first time.
func _ready():
	random.randomize()
	var bolt_index = str(random.randi_range(0,2))
	var bolt_file_name = "bolt_" + bolt_index + ".png"
	var resource = null
	connect("body_exited" , self , "_on_Ammo_body_exited")
	connect("body_entered" , self , "_on_Ammo_body_entered")
	print(self.name)
	
	if (type == "bolt"):
		match bolt_index:
			"0":
				resource = load(collectible_image_path + bolt_file_name)
				$Sprite3D.set_texture(resource)
			"1":
				resource = load(collectible_image_path + bolt_file_name)
				$Sprite3D.set_texture(resource)
			"2":
				resource = load(collectible_image_path + bolt_file_name)
				$Sprite3D.set_texture(resource)
	elif (type == "ammo"):
		resource = load(collectible_image_path + "ammo_can.png")
		$Sprite3D.set_texture(resource)

					
func _physics_process(delta):
	if getMagnet == false:
		#makes the bolts fall due to the y axis
		translation.y
		
	var bodies=get_overlapping_areas()
	for body in bodies:
		if body.name=="AreaPlayer":
			getMagnet=true
			translation +=(get_parent().get_node("player").translation-translation)/10
		var bodies2=get_overlapping_bodies()
		for bod in bodies2:
			#this add the bolt amount to the player
			
			if bod.name=="player":
				#makes sure that every number is random
				random.randomize()
				var countBoults=get_parent().get_node("player").bolt+random.randi_range(10,100)
				#grabes the bolt amout
				Globle.bolts+=countBoults
				# print(Globle.bolts)
				
				# Plays the bolt sound on the player's instance.
				if bod.has_method("collect_bolt"):
					if (type == "bolt"):
						bod.collect_bolt(random.randi_range(0,2), "bolt")
					elif (type == "ammo"):
						# TODO active the ui notfication on the player 
						bod.collect_bolt(random.randi_range(0,1), "ammo")
				queue_free()
				
#func _process(delta):
	
	#if (type == "bolt"):
		#hides the notification
		#$CanvasLayer/Ui_notification.hide()
	#elif (type == "ammo"):	
		#shows the notification
		#timer.wait_time+=delta
		#$CanvasLayer/Ui_notification.visible=active
		
func _on_Ammo_body_exited(body):
	if (timer.wait_time==3):
		active=false
		print(timer.wait_time)
		print("body has exited the xxx can")

func _on_Ammo_body_entered(body):
	if body.name == "player":
		print("body has entered the xxx can")
		timer = Timer.new()
		add_child(timer)
		timer.autostart = true
		timer.wait_time = 1
		timer.connect("timeout", self, "_timeout")
		active=true
		print("Timed out!")
