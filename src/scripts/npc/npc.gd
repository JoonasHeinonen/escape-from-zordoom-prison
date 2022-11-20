extends Area

var active=false
var value=0
var dialog
func _ready():
	connect("body_entered",self,"_on_NPC_body_entered")
	connect("body_exited",self,"_on_NPC_body_exited")
	
"""
func _physics_process(delta):
	print(value)
	print(active)
"""
func _input(event):
	if get_node_or_null('DialogNode')==null:
			if Input.is_action_just_pressed("ui_accept") and active==true: 
				
				match(value):
					(0):
						get_tree().paused=true
						var dialog=Dialogic.start('timeline-1')
						dialog.pause_mode=Node.PAUSE_MODE_PROCESS
						dialog.connect('timeline_end',self,'unpause')
						add_child(dialog)
						print(active)
					(2):
						
						get_tree().paused=true
						var dialog=Dialogic.start('timeline-2')
						dialog.pause_mode=Node.PAUSE_MODE_PROCESS
						dialog.connect('timeline_end',self,'unpause')
						add_child(dialog)
						print(active)
					(4):
						
						get_tree().paused=true
						var dialog=Dialogic.start('timeline-3')
						dialog.pause_mode=Node.PAUSE_MODE_PROCESS
						dialog.connect('timeline_end',self,'unpause')
						add_child(dialog)
						print(active)
				value+=1
				if value>4 and active==true:
					value=4
					active=false
					
				
				"""
				if Input.is_action_pressed("ui_accept") and active==true:
				value+=1
				if value==2:
					get_tree().paused=true
					var dialog=Dialogic.start('timeline-2')
					dialog.pause_mode=Node.PAUSE_MODE_PROCESS
					dialog.connect('timeline_end',self,'unpause')
					add_child(dialog)
					active=false
				elif value==4:
					get_tree().paused=true
					var dialog=Dialogic.start('timeline-3')
					dialog.pause_mode=Node.PAUSE_MODE_PROCESS
					dialog.connect('timeline_end',self,'unpause')
					add_child(dialog)
					active=false
				"""
			
				
				
func unpause(timeline_name):
	get_tree().paused=false
func _on_NPC_body_entered(body):
	if body.name == "player":
		active=true
		print("body has entered the npc")
func _on_NPC_body_exited(body):
	if body.name == "player":
		active=false
		print("body has exited the npc")
