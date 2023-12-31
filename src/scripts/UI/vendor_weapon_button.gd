extends Button

@export var wpn_for_sale : String

func set_label(replace_text = $VendorWeaponButton.text):
	self.text = replace_text

func set_wpn_for_sale(wpn):
	self.wpn_for_sale = wpn

func _on_VendorWeaponButton_focus_exited():
	$Audio/Move.play()

func _on_VendorWeaponButton_pressed():
	$Audio/Click.play()
