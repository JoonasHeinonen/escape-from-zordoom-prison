[1mdiff --git a/resources/audio/weapons/player/theNegotiator.wav b/resources/audio/weapons/player/theNegotiator.wav[m
[1mdeleted file mode 100644[m
[1mindex 6fcc0f6..0000000[m
Binary files a/resources/audio/weapons/player/theNegotiator.wav and /dev/null differ
[1mdiff --git a/resources/audio/weapons/player/theNegotiator.wav.import b/resources/audio/weapons/player/theNegotiator.wav.import[m
[1mdeleted file mode 100644[m
[1mindex 64326a6..0000000[m
[1m--- a/resources/audio/weapons/player/theNegotiator.wav.import[m
[1m+++ /dev/null[m
[36m@@ -1,23 +0,0 @@[m
[31m-[remap][m
[31m-[m
[31m-importer="wav"[m
[31m-type="AudioStreamSample"[m
[31m-path="res://.import/theNegotiator.wav-86a6d5bef867597689334830151f154f.sample"[m
[31m-[m
[31m-[deps][m
[31m-[m
[31m-source_file="res://resources/audio/weapons/player/theNegotiator.wav"[m
[31m-dest_files=[ "res://.import/theNegotiator.wav-86a6d5bef867597689334830151f154f.sample" ][m
[31m-[m
[31m-[params][m
[31m-[m
[31m-force/8_bit=false[m
[31m-force/mono=false[m
[31m-force/max_rate=false[m
[31m-force/max_rate_hz=44100[m
[31m-edit/trim=false[m
[31m-edit/normalize=false[m
[31m-edit/loop_mode=0[m
[31m-edit/loop_begin=0[m
[31m-edit/loop_end=-1[m
[31m-compress/mode=0[m
[1mdiff --git a/resources/images/effects/projectiles/gravity_bomb_projectile.png.import b/resources/images/effects/projectiles/gravity_bomb_projectile.png.import[m
[1mindex 9f061a0..2298736 100644[m
[1m--- a/resources/images/effects/projectiles/gravity_bomb_projectile.png.import[m
[1m+++ b/resources/images/effects/projectiles/gravity_bomb_projectile.png.import[m
[36m@@ -22,7 +22,7 @@[m [mcompress/hdr_mode=0[m
 compress/bptc_ldr=0[m
 compress/normal_map=0[m
 flags/repeat=true[m
[31m-flags/filter=false[m
[32m+[m[32mflags/filter=true[m
 flags/mipmaps=true[m
 flags/anisotropic=false[m
 flags/srgb=1[m
[1mdiff --git a/resources/images/effects/projectiles/negotiator_projectile.png b/resources/images/effects/projectiles/negotiator_projectile.png[m
[1mdeleted file mode 100644[m
[1mindex 891a474..0000000[m
Binary files a/resources/images/effects/projectiles/negotiator_projectile.png and /dev/null differ
[1mdiff --git a/resources/images/effects/projectiles/negotiator_projectile.png.import b/resources/images/effects/projectiles/negotiator_projectile.png.import[m
[1mdeleted file mode 100644[m
[1mindex 921184a..0000000[m
[1m--- a/resources/images/effects/projectiles/negotiator_projectile.png.import[m
[1m+++ /dev/null[m
[36m@@ -1,37 +0,0 @@[m
[31m-[remap][m
[31m-[m
[31m-importer="texture"[m
[31m-type="StreamTexture"[m
[31m-path.s3tc="res://.import/negotiator_projectile.png-12bd8a70a7b5b584b87fa823f4394543.s3tc.stex"[m
[31m-path.etc2="res://.import/negotiator_projectile.png-12bd8a70a7b5b584b87fa823f4394543.etc2.stex"[m
[31m-metadata={[m
[31m-"imported_formats": [ "s3tc", "etc2" ],[m
[31m-"vram_texture": true[m
[31m-}[m
[31m-[m
[31m-[deps][m
[31m-[m
[31m-source_file="res://resources/images/effects/projectiles/negotiator_projectile.png"[m
[31m-dest_files=[ "res://.import/negotiator_projectile.png-12bd8a70a7b5b584b87fa823f4394543.s3tc.stex", "res://.import/negotiator_projectile.png-12bd8a70a7b5b584b87fa823f4394543.etc2.stex" ][m
[31m-[m
[31m-[params][m
[31m-[m
[31m-compress/mode=2[m
[31m-compress/lossy_quality=0.7[m
[31m-compress/hdr_mode=0[m
[31m-compress/bptc_ldr=0[m
[31m-compress/normal_map=0[m
[31m-flags/repeat=true[m
[31m-flags/filter=false[m
[31m-flags/mipmaps=true[m
[31m-flags/anisotropic=false[m
[31m-flags/srgb=1[m
[31m-process/fix_alpha_border=true[m
[31m-process/premult_alpha=false[m
[31m-process/HDR_as_SRGB=false[m
[31m-process/invert_color=false[m
[31m-process/normal_map_invert_y=false[m
[31m-stream=false[m
[31m-size_limit=0[m
[31m-detect_3d=false[m
[31m-svg/scale=1.0[m
[1mdiff --git a/resources/images/effects/projectiles/negotiator_projectile.png~ b/resources/images/effects/projectiles/negotiator_projectile.png~[m
[1mdeleted file mode 100644[m
[1mindex 567880a..0000000[m
Binary files a/resources/images/effects/projectiles/negotiator_projectile.png~ and /dev/null differ
[1mdiff --git a/scenes/Effects/Collectibles/BoltSparkle.tscn b/scenes/Effects/Collectibles/BoltSparkle.tscn[m
[1mindex cf26d2b..68c0637 100644[m
[1m--- a/scenes/Effects/Collectibles/BoltSparkle.tscn[m
[1m+++ b/scenes/Effects/Collectibles/BoltSparkle.tscn[m
[36m@@ -3,7 +3,6 @@[m
 [ext_resource path="res://resources/images/effects/explosions_n_fire/sparkle.png" type="Texture" id=1][m
 [ext_resource path="res://src/scripts/effects/explosions/explosive_crate_explosion.gd" type="Script" id=2][m
 [m
[31m-[m
 [sub_resource type="SpatialMaterial" id=1][m
 flags_unshaded = true[m
 vertex_color_use_as_albedo = true[m
[1mdiff --git a/scenes/Effects/ProjectileEffects/BlasterProjectileEffect.tscn b/scenes/Effects/ProjectileEffects/BlasterProjectileEffect.tscn[m
[1mindex a02c336..e479677 100644[m
[1m--- a/scenes/Effects/ProjectileEffects/BlasterProjectileEffect.tscn[m
[1m+++ b/scenes/Effects/ProjectileEffects/BlasterProjectileEffect.tscn[m
[36m@@ -44,7 +44,7 @@[m [mdisabled = true[m
 transform = Transform( 4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0 )[m
 texture = ExtResource( 1 )[m
 hframes = 8[m
[31m-frame = 1[m
[32m+[m[32mframe = 2[m
 [m
 [node name="AnimationPlayer" type="AnimationPlayer" parent="."][m
 playback_speed = 4.0[m
[1mdiff --git a/scenes/Effects/ProjectileEffects/BlasterProjectileExplosion.tscn b/scenes/Effects/ProjectileEffects/BlasterProjectileExplosion.tscn[m
[1mindex 8d97047..34079a6 100644[m
[1m--- a/scenes/Effects/ProjectileEffects/BlasterProjectileExplosion.tscn[m
[1m+++ b/scenes/Effects/ProjectileEffects/BlasterProjectileExplosion.tscn[m
[36m@@ -73,7 +73,7 @@[m [mparameters/playback = SubResource( 3 )[m
 [m
 [node name="OmniLight" type="OmniLight" parent="."][m
 transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0.0631409 )[m
[31m-omni_range = 0.652481[m
[32m+[m[32momni_range = 0.840938[m
 [m
 [node name="ProjectileExplosionArea" type="Area" parent="."][m
 transform = Transform( 1.75, 0, 0, 0, 1.75, 0, 0, 0, 1.75, 0, 0, 0 )[m
[1mdiff --git a/scenes/Effects/ProjectileEffects/BlitzGunProjectileExplosion.tscn b/scenes/Effects/ProjectileEffects/BlitzGunProjectileExplosion.tscn[m
[1mindex 3300f61..389b744 100644[m
[1m--- a/scenes/Effects/ProjectileEffects/BlitzGunProjectileExplosion.tscn[m
[1m+++ b/scenes/Effects/ProjectileEffects/BlitzGunProjectileExplosion.tscn[m
[36m@@ -58,7 +58,7 @@[m [mdisabled = true[m
 transform = Transform( 4, 0, 0, 0, 4, 0, 0, 0, 4, 0, 0, 0 )[m
 texture = ExtResource( 1 )[m
 hframes = 5[m
[31m-frame = 3[m
[32m+[m[32mframe = 4[m
 [m
 [node name="AnimationPlayer" type="AnimationPlayer" parent="KinematicBody"][m
 anims/BlasterProjectileExplosion = SubResource( 7 )[m
[36m@@ -71,7 +71,7 @@[m [mparameters/playback = SubResource( 9 )[m
 [m
 [node name="OmniLight" type="OmniLight" parent="KinematicBody"][m
 transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0.0631409 )[m
[31m-omni_range = 0.910149[m
[32m+[m[32momni_range = 0.737704[m
 [m
 [node name="ProjectileExplosionArea" type="Area" parent="KinematicBody"][m
 transform = Transform( 1.75, 0, 0, 0, 1.75, 0, 0, 0, 1.75, 0, 0, 0 )[m
[1mdiff --git a/scenes/Effects/ProjectileEffects/NegotiatorExplosion.tscn b/scenes/Effects/ProjectileEffects/NegotiatorExplosion.tscn[m
[1mdeleted file mode 100644[m
[1mindex 6adda46..0000000[m
[1m--- a/scenes/Effects/ProjectileEffects/NegotiatorExplosion.tscn[m
[1m+++ /dev/null[m
[36m@@ -1,62 +0,0 @@[m
[31m-[gd_scene load_steps=11 format=2][m
[31m-[m
[31m-[ext_resource path="res://resources/images/effects/explosions_n_fire/explosion.png" type="Texture" id=1][m
[31m-[ext_resource path="res://src/scripts/effects/explosions/Negotiator_explosion.gd" type="Script" id=2][m
[31m-[ext_resource path="res://src/scripts/effects/explosions/ProjectileExplosionArea_timer.gd" type="Script" id=3][m
[31m-[m
[31m-[sub_resource type="SpatialMaterial" id=2][m
[31m-flags_transparent = true[m
[31m-flags_unshaded = true[m
[31m-vertex_color_use_as_albedo = true[m
[31m-params_blend_mode = 1[m
[31m-params_billboard_mode = 3[m
[31m-particles_anim_h_frames = 1[m
[31m-particles_anim_v_frames = 1[m
[31m-particles_anim_loop = false[m
[31m-albedo_texture = ExtResource( 1 )[m
[31m-[m
[31m-[sub_resource type="Gradient" id=5][m
[31m-colors = PoolColorArray( 0.842773, 0.734332, 0.35143, 1, 0.963867, 0.424793, 0.0931864, 1 )[m
[31m-[m
[31m-[sub_resource type="GradientTexture" id=6][m
[31m-gradient = SubResource( 5 )[m
[31m-[m
[31m-[sub_resource type="ParticlesMaterial" id=3][m
[31m-gravity = Vector3( 0, 0, 0 )[m
[31m-angle = 180.0[m
[31m-angle_random = 1.0[m
[31m-color = Color( 0.827451, 0.686275, 0.501961, 1 )[m
[31m-color_ramp = SubResource( 6 )[m
[31m-[m
[31m-[sub_resource type="QuadMesh" id=4][m
[31m-[m
[31m-[sub_resource type="BoxShape" id=1][m
[31m-[m
[31m-[sub_resource type="BoxShape" id=7][m
[31m-[m
[31m-[node name="Spatial" type="Spatial"][m
[31m-[m
[31m-[node name="KillTimer" type="Timer" parent="."][m
[31m-wait_time = 0.5[m
[31m-autostart = true[m
[31m-[m
[31m-[node name="KinematicBody" type="KinematicBody" parent="."][m
[31m-script = ExtResource( 2 )[m
[31m-[m
[31m-[node name="Particles" type="Particles" parent="KinematicBody"][m
[31m-material_override = SubResource( 2 )[m
[31m-amount = 20[m
[31m-process_material = SubResource( 3 )[m
[31m-draw_pass_1 = SubResource( 4 )[m
[31m-[m
[31m-[node name="CollisionShape" type="CollisionShape" parent="KinematicBody"][m
[31m-shape = SubResource( 1 )[m
[31m-disabled = true[m
[31m-[m
[31m-[node name="ProjectileExplosionArea" type="Area" parent="."][m
[31m-transform = Transform( 1.75, 0, 0, 0, 1.75, 0, 0, 0, 1.75, 0, 0, 0 )[m
[31m-script = ExtResource( 3 )[m
[31m-[m
[31m-[node name="CollisionShape" type="CollisionShape" parent="ProjectileExplosionArea"][m
[31m-transform = Transform( 0.25, 0, 0, 0, 0.25, 0, 0, 0, 0.25, 0, 0, 0 )[m
[31m-shape = SubResource( 7 )[m
[1mdiff --git a/scenes/Player/player.tscn b/scenes/Player/player.tscn[m
[1mindex 1473c8e..8a50f2a 100644[m
[1m--- a/scenes/Player/player.tscn[m
[1m+++ b/scenes/Player/player.tscn[m
[36m@@ -1,4 +1,4 @@[m
[31m-[gd_scene load_steps=79 format=2][m
[32m+[m[32m[gd_scene load_steps=78 format=2][m
 [m
 [ext_resource path="res://src/scripts/Player/Player.gd" type="Script" id=1][m
 [ext_resource path="res://icon.png" type="Texture" id=2][m
[36m@@ -12,7 +12,7 @@[m
 [ext_resource path="res://src/scripts/npc/vendor_container.gd" type="Script" id=10][m
 [ext_resource path="res://src/theme/zordoom_resource_theme.tres" type="Theme" id=11][m
 [ext_resource path="res://scenes/UI/bolt-icon.png" type="Texture" id=12][m
[31m-[ext_resource path="res://src/scripts/UI/boltCount.gd" type="Script" id=13][m
[32m+[m[32m[ext_resource path="res://src/scripts/UI/bolt_count.gd" type="Script" id=13][m
 [ext_resource path="res://src/scripts/Player/PlayerWeaponsInventory.gd" type="Script" id=14][m
 [ext_resource path="res://src/scripts/Player/PlayerHit_box.gd" type="Script" id=15][m
 [ext_resource path="res://resources/audio/weapons/player/edge_blaster.wav" type="AudioStream" id=16][m
[36m@@ -39,7 +39,6 @@[m
 [ext_resource path="res://resources/audio/weapons/player/GravityBomb.wav" type="AudioStream" id=37][m
 [ext_resource path="res://src/scripts/Player/player_target_detection_area.gd" type="Script" id=38][m
 [ext_resource path="res://resources/audio/collectibles/Ratchet_&_Clank_-_Going_Commando.iso_59400.wav" type="AudioStream" id=39][m
[31m-[ext_resource path="res://resources/audio/weapons/player/theNegotiator.wav" type="AudioStream" id=40][m
 [m
 [sub_resource type="BoxShape" id=5][m
 [m
[36m@@ -488,7 +487,6 @@[m [mdouble_sided = false[m
 texture = ExtResource( 3 )[m
 hframes = 10[m
 vframes = 3[m
[31m-frame = 2[m
 [m
 [node name="SpotLight" type="SpotLight" parent="AngelaSprite"][m
 transform = Transform( 1, 0, 0, 0, 1, 0, 0, 0, 1, -0.115846, -0.281346, 0.10579 )[m
[36m@@ -540,7 +538,7 @@[m [mtexture = ExtResource( 5 )[m
 transform = Transform( 1, 7.10543e-15, 0, -7.10543e-15, 1, 0, 0, -2.82728e-27, 1, 0.498717, 0.165527, 0 )[m
 [m
 [node name="WeaponMuzzle" type="Position3D" parent="AngelaSprite/MeshInstance/HandInstance/Hand/WeaponPlaceHolder"][m
[31m-transform = Transform( 1, 3.55271e-15, 0, -3.55271e-15, 1, 0, 0, 0, 1, 0.610582, 0.153141, 0 )[m
[32m+[m[32mtransform = Transform( 1, 1.77636e-15, 0, -1.77636e-15, 1, 0, 0, 0, 1, 1.07431, 0.153141, 0 )[m
 [m
 [node name="AngelaAnimationPlayer" type="AnimationPlayer" parent="."][m
 anims/Player_Fall = SubResource( 15 )[m
[36m@@ -1191,9 +1189,6 @@[m [mstream = ExtResource( 37 )[m
 [node name="BlizGun" type="AudioStreamPlayer" parent="Audio"][m
 stream = ExtResource( 28 )[m
 [m
[31m-[node name="theNegotiator" type="AudioStreamPlayer" parent="Audio"][m
[31m-stream = ExtResource( 40 )[m
[31m-[m
 [node name="EdgeBlaster" type="AudioStreamPlayer" parent="Audio"][m
 stream = ExtResource( 16 )[m
 [m
[1mdiff --git a/scenes/Projectiles/NegotiatorProjectile.tscn b/scenes/Projectiles/NegotiatorProjectile.tscn[m
[1mdeleted file mode 100644[m
[1mindex 73c4e4b..0000000[m
[1m--- a/scenes/Projectiles/NegotiatorProjectile.tscn[m
[1m+++ /dev/null[m
[36m@@ -1,43 +0,0 @@[m
[31m-[gd_scene load_steps=5 format=2][m
[31m-[m
[31m-[ext_resource path="res://src/scripts/effects/bullets/Negotiator_Projectile.gd" type="Script" id=2][m
[31m-[m
[31m-[sub_resource type="StreamTexture" id=3][m
[31m-flags = 23[m
[31m-load_path = "res://.import/negotiator_projectile.png-12bd8a70a7b5b584b87fa823f4394543.s3tc.stex"[m
[31m-[m
[31m-[sub_resource type="BoxShape" id=1][m
[31m-extents = Vector3( 0.624757, 0.471215, 1 )[m
[31m-[m
[31m-[sub_resource type="BoxShape" id=2][m
[31m-[m
[31m-[node name="KinematicBody" type="RigidBody"][m
[31m-axis_lock_angular_x = true[m
[31m-axis_lock_angular_y = true[m
[31m-axis_lock_angular_z = true[m
[31m-script = ExtResource( 2 )[m
[31m-[m
[31m-[node name="Sprite3D" type="Sprite3D" parent="."][m
[31m-transform = Transform( 5, 0, 0, 0, 5, 0, 0, 0, 1, 0, 0, 0 )[m
[31m-texture = SubResource( 3 )[m
[31m-[m
[31m-[node name="CollisionShape" type="CollisionShape" parent="."][m
[31m-shape = SubResource( 1 )[m
[31m-disabled = true[m
[31m-[m
[31m-[node name="Explosion" type="Position3D" parent="."][m
[31m-transform = Transform( 0.999946, 0.0103496, 0, -0.0103496, 0.999946, 0, 0, 0, 1, 0.321947, 0, 0 )[m
[31m-[m
[31m-[node name="KillTimer" type="Timer" parent="."][m
[31m-wait_time = 0.5[m
[31m-autostart = true[m
[31m-[m
[31m-[node name="ProjectileArea" type="Area" parent="."][m
[31m-transform = Transform( 1.75, 0, 0, 0, 1.75, 0, 0, 0, 1.75, 0, 0, 0 )[m
[31m-[m
[31m-[node name="CollisionShape" type="CollisionShape" parent="ProjectileArea"][m
[31m-transform = Transform( 0.25, 0, 0, 0, 0.25, 0, 0, 0, 0.25, 0, 0, 0 )[m
[31m-shape = SubResource( 2 )[m
[31m-[m
[31m-[connection signal="body_entered" from="." to="." method="_on_KinematicBody_body_entered"][m
[31m-[connection signal="body_entered" from="ProjectileArea" to="." method="_on_ProjectileArea_body_entered"][m
[1mdiff --git a/scenes/UI/BoltCounter.tscn b/scenes/UI/BoltCounter.tscn[m
[1mindex dbbc5e6..e5073e1 100644[m
[1m--- a/scenes/UI/BoltCounter.tscn[m
[1m+++ b/scenes/UI/BoltCounter.tscn[m
[36m@@ -1,6 +1,6 @@[m
 [gd_scene load_steps=4 format=2][m
 [m
[31m-[ext_resource path="res://src/scripts/UI/boltCount.gd" type="Script" id=1][m
[32m+[m[32m[ext_resource path="res://src/scripts/UI/bolt_count.gd" type="Script" id=1][m
 [ext_resource path="res://resources/fonts/rg-future-italic.tres" type="DynamicFont" id=2][m
 [ext_resource path="res://scenes/UI/bolt-icon.png" type="Texture" id=3][m
 [m
[1mdiff --git a/src/scripts/Globle.gd b/src/scripts/Globle.gd[m
[1mindex 2b5c352..b976417 100644[m
[1m--- a/src/scripts/Globle.gd[m
[1m+++ b/src/scripts/Globle.gd[m
[36m@@ -32,7 +32,7 @@[m [mvar bolts 			 	= 0[m
 var weapons_for_sale 	= [[m
 	"edge_blaster", "blitz_gun", "gravity_bomb", "negotiator", "pulse_rifle", "ry3no", "sheepinator"[m
 ][m
[31m-var current_weapons  	= ["edge_blaster", "gravity_bomb" , "negotiator"][m
[32m+[m[32mvar current_weapons  	= ["edge_blaster", "gravity_bomb"][m
 [m
 var player_inventory 	= false[m
 var vendor_open 	 	= false[m
[1mdiff --git a/src/scripts/Player/Player.gd b/src/scripts/Player/Player.gd[m
[1mindex 1abf734..e6ceeb1 100644[m
[1m--- a/src/scripts/Player/Player.gd[m
[1m+++ b/src/scripts/Player/Player.gd[m
[36m@@ -6,7 +6,7 @@[m [monready var projectile 	  		 = preload("res://scenes/Projectiles/BlasterProjecti[m
 onready var blitzGunProjectile 	 = preload("res://scenes/Projectiles/BlitzGunProjectile.tscn")[m
 onready var bolt_sparkle 		 = preload("res://scenes/Effects/Collectibles/BoltSparkle.tscn")[m
 onready var gravityBombProjectile = preload("res://scenes/Projectiles/GravityBombProjectile.tscn")[m
[31m-onready var negotiatorProjectile = preload("res://scenes/Projectiles/NegotiatorProjectile.tscn")[m
[32m+[m
 onready var gun_btn 	  		 = preload("res://scenes/UI/VendorWeaponButton.tscn")[m
 [m
 onready var angela_mesh_instance = $AngelaSprite/MeshInstance[m
[36m@@ -380,11 +380,7 @@[m [mfunc shoot_gravity_bomb():[m
 	[m
 # Shooting functionality for the negotiator.[m
 func shoot_negotiator():[m
[31m-	$Audio/theNegotiator.play()[m
[31m-	var bullet = negotiatorProjectile.instance()[m
[31m-	bullet.translation.x = 3[m
[31m-	get_parent().add_child(bullet)[m
[31m-	bullet.global_transform = $AngelaSprite/MeshInstance/HandInstance/Hand/WeaponPlaceHolder/WeaponMuzzle.global_transform[m
[32m+[m	[32mprint("You have negotiated your enemies... To surrender...")[m
 [m
 # Shooting functionality for the pulse rifle.[m
 func shoot_pulse_rifle():[m
[1mdiff --git a/src/scripts/UI/boltCount.gd b/src/scripts/UI/boltCount.gd[m
[1mdeleted file mode 100644[m
[1mindex 667e058..0000000[m
[1m--- a/src/scripts/UI/boltCount.gd[m
[1m+++ /dev/null[m
[36m@@ -1,5 +0,0 @@[m
[31m-extends Label[m
[31m-#displays the amout on the player screen.[m
[31m-func _process(delta):[m
[31m-	text=String($"/root/Globle".bolts)[m
[31m-	pass[m
[1mdiff --git a/src/scripts/UI/bolt_count.gd b/src/scripts/UI/bolt_count.gd[m
[1mnew file mode 100644[m
[1mindex 0000000..f28f045[m
[1m--- /dev/null[m
[1m+++ b/src/scripts/UI/bolt_count.gd[m
[36m@@ -0,0 +1,14 @@[m
[32m+[m[32mextends Label[m
[32m+[m
[32m+[m[32m# Displays the amout on the player screen.[m
[32m+[m[32mfunc _process(delta):[m
[32m+[m	[32mtext = format_bolt_amount(Globle.bolts)[m
[32m+[m
[32m+[m[32m# Format bolts in a correct manner.[m
[32m+[m[32mfunc format_bolt_amount(bolts : int) -> String:[m
[32m+[m	[32mvar str_bolts : String = str(bolts)[m
[32m+[m
[32m+[m	[32m# Set the comma to the each 3rd place on the string.[m
[32m+[m	[32mfor c in range(str_bolts.length() -3, 0, -3):[m
[32m+[m		[32mstr_bolts = str_bolts.insert(c, ",")[m
[32m+[m	[32mreturn str_bolts[m
[1mdiff --git a/src/scripts/effects/bullets/Negotiator_Projectile.gd b/src/scripts/effects/bullets/Negotiator_Projectile.gd[m
[1mdeleted file mode 100644[m
[1mindex 2729143..0000000[m
[1m--- a/src/scripts/effects/bullets/Negotiator_Projectile.gd[m
[1m+++ /dev/null[m
[36m@@ -1,19 +0,0 @@[m
[31m-extends RigidBody[m
[31m-[m
[31m-var speed = 8[m
[31m-var velocity = Vector3(0,0,0)[m
[31m-onready var projectile_explosion = preload("res://scenes/Effects/ProjectileEffects/NegotiatorExplosion.tscn")[m
[31m-[m
[31m-func _ready():[m
[31m-	$KillTimer.connect("timeout", self, "_on_KillTimer_timeout")[m
[31m-	$KillTimer.start()[m
[31m-[m
[31m-func _physics_process(delta):[m
[31m-	velocity.x = speed * delta * 1[m
[31m-	translate(velocity)[m
[31m-[m
[31m-func _on_ProjectileArea_body_entered(body):[m
[31m-	var explosion = projectile_explosion.instance()[m
[31m-	get_tree().current_scene.add_child(explosion)[m
[31m-	explosion.global_transform = $Explosion.global_transform[m
[31m-	queue_free()[m
[1mdiff --git a/src/scripts/effects/explosions/Negotiator_explosion.gd b/src/scripts/effects/explosions/Negotiator_explosion.gd[m
[1mdeleted file mode 100644[m
[1mindex e4d0656..0000000[m
[1m--- a/src/scripts/effects/explosions/Negotiator_explosion.gd[m
[1m+++ /dev/null[m
[36m@@ -1,16 +0,0 @@[m
[31m-extends KinematicBody[m
[31m-[m
[31m-func _ready():[m
[31m-	[m
[31m-	$"../KillTimer".connect("timeout", self, "_on_KillTimer_timeout")[m
[31m-	$"../KillTimer".start()[m
[31m-func _on_KillTimer_timeout():[m
[31m-	queue_free()[m
[31m-func _physics_process(delta):[m
[31m-	self.rotation.x = 0[m
[31m-	self.rotation.y = 0[m
[31m-	self.rotation.z = 0[m
[31m-func debug_rotation_values(x, y, z):[m
[31m-	var values = "Rotation values: %s %s %s."	[m
[31m-	var args = values % [x, y, z][m
[31m-	print(args)[m
