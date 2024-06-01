extends CharacterBody3D

class_name MissionParameter

@onready var level = get_parent()

func _ready():
	print("Mission parameter")

func _on_player_detection_body_entered(body):
	if body.name == "player":
		print("Player here")
		pass # active = true
		## TODO Pseudocode list:
		## 1. Conenct to the level.
		## 2. Check the mission parameters of the level.
		## 3. Mark the mission parameter as done.
		## 4. Remove the entity itself.
		self.queue_free()
