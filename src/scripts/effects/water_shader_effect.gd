extends Node3D

func _ready():
	var sim_viewport : SubViewport = $Simulation
	var sim_material: ShaderMaterial = $Simulation/ColorRect.material
	sim_material.set_shader_parameter('sim_text',sim_viewport.get_texture())