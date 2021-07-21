
event_inherited();
tex = baku_mine_spr_iron_ore;
is_ore = true;
glow_col = c_white;
glow_alpha = 0;
drop_tex = baku_mine_spr_iron_drop;

// Default ore type (should be overridden by player obj)
ore_type = irandom(baku_mine_ore_type.__size - 1);

// Updating ore type function
set_ore_type = function() {
	switch ore_type {
		case baku_mine_ore_type.diamond:
			tex = baku_mine_spr_diamond_ore;
			drop_tex = baku_mine_spr_diamond_drop;
			glow_col = 0xb8a44f;
			glow_alpha = 0.15;
		break;
		case baku_mine_ore_type.emerald:
			tex = baku_mine_spr_emerald_ore;
			drop_tex = baku_mine_spr_emerald_drop;
			glow_col = 0x3fab63;
			glow_alpha = 0.15;
		break;
		case baku_mine_ore_type.gold:
			tex = baku_mine_spr_gold_ore;
			drop_tex = baku_mine_spr_gold_drop;
			glow_col = 0x41b5f0;
			glow_alpha = 0.15;
		break;
		case baku_mine_ore_type.redstone:
			tex = baku_mine_spr_redstone_ore;
			drop_tex = baku_mine_spr_redstone_drop;
			glow_col = 0x3945e6;
			glow_alpha = 0.15;
		break;
		case baku_mine_ore_type.iron:
			tex = baku_mine_spr_iron_ore;
			drop_tex = baku_mine_spr_iron_drop;
			glow_col = 0x626abd;
			glow_alpha = 0.15;
		break;
	}
}

// Apply default ore type
set_ore_type();