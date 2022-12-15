extends Button

export (String) var wpn_for_sale

# Set the label for a menu button.
func set_label(replace_text = $VendorWeaponButton.text):
	self.text = replace_text

# Set the scene to be changed to.
func set_wpn_for_sale(wpn):
	self.wpn_for_sale = wpn
