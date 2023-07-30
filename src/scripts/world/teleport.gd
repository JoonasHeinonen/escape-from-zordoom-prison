extends StaticBody

export(String, "First", "Second") var teleport_index

var target_teleport : String

# Called when the node enters the scene tree for the first time.
func _ready():
	define_target_teleport()

## To define the target teleport in the parent scene.
func define_target_teleport():
	var target_teleport_index
	var cleaned_name := self.name
	cleaned_name = cleaned_name.left(cleaned_name.length() - 1)

	## Determine the order of the teleports by their index.
	match teleport_index:
		"First":
			target_teleport_index = int(self.name[-1]) + 1
		"Second":
			target_teleport_index = int(self.name[-1]) - 1
	target_teleport = cleaned_name + str(target_teleport_index)
	print(self.name, " to ", target_teleport)

## To teleport the player to the target teleport.
func teleport_player():
	pass

func _on_TekeportationArea_body_entered(body):
	if body.name == "player":
		print("Player is teleported from ", self.name, " to ", target_teleport, ".")

func _on_TekeportationArea_body_exited(body):
	if body.name == "player":
		print("Player is not being teleported from ", self.name, " to ", target_teleport, "...")
