
event_inherited();
is_ore = true;
glow_col = c_white;
glow_alpha = 0;
texture_name = "ore_iron";
texture_name_drop = "drop_iron";

// Default ore type (should be overridden by player obj)
ore_type = irandom(baku_mine_ore_type.__size - 1);

// Updating ore type function
set_ore_type = function() {
	switch ore_type {
		case baku_mine_ore_type.diamond:
			glow_col = 0xb8a44f;
			glow_alpha = 0.15;
			texture_name = "ore_diamond";
			texture_name_drop = "drop_diamond";
		break;
		case baku_mine_ore_type.emerald:
			glow_col = 0x3fab63;
			glow_alpha = 0.15;
			texture_name = "ore_emerald";
			texture_name_drop = "drop_emerald";
		break;
		case baku_mine_ore_type.gold:
			glow_col = 0x41b5f0;
			glow_alpha = 0.15;
			texture_name = "ore_gold";
			texture_name_drop = "drop_gold";
		break;
		case baku_mine_ore_type.redstone:
			glow_col = 0x3945e6;
			glow_alpha = 0.15;
			texture_name = "ore_redstone";
			texture_name_drop = "drop_redstone";
		break;
		case baku_mine_ore_type.iron:
			glow_col = 0x626abd;
			glow_alpha = 0.15;
			texture_name = "ore_iron";
			texture_name_drop = "drop_iron";
		break;
	}
}

// Apply default ore type
set_ore_type();