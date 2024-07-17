/*
 * -----------------------------------------
 * PROGRAM-WIDE INIT
 * run only once ever!!!
 * -----------------------------------------
 */

#macro ___DEBUG_MENU_STRUCT global.___debug_menu

if os_get_config()=="Default" { //only defined if debugging
	___DEBUG_MENU_STRUCT = {
		open: false,
		accessible: true, //able to be opened
		
		
		//keep track of debug overlay element pointers
		dbg_elements: {
			view_resources: undefined,
			section_resources: undefined,
		},
		
		
		//vars for "Resource counts" view
		tracking_resources: false,
		resource_counts: {},
		update_resource_counts: function() {
			//update/recreate the section with resource counts
			
			dbg_section_delete(dbg_elements.section_resources);
			dbg_elements.section_resources = dbg_section("Counts");
			
			var names = struct_get_names(resource_counts);
			var nlen = array_length(names);
			var name,val;
			for(var i=0; i<nlen; i++) {
				name = names[i];
				if string_pos("count",string_lower(name))==0 continue; //only resource counts
				val = resource_counts[$ name];
				if val==0 continue; //only > 0
				dbg_text($"{name}: {val}"); //create text element listing the count
			}
		},
		ts_resources: call_later(1,time_source_units_seconds,function(){ //repeating check
			with (___DEBUG_MENU_STRUCT) {
				if is_debug_overlay_open() {
					if tracking_resources {
						resource_counts = debug_event("ResourceCounts",true);
						update_resource_counts();
					}
					else if !is_undefined(dbg_elements.section_resources) {
						//close section
						dbg_section_delete(dbg_elements.section_resources);
						dbg_elements.section_resources = undefined;
					}
				}
			}
		},true),
		
		
		////methods
		toggle: function(state=!is_debug_overlay_open()){
			
			show_debug_overlay(state,true);
			open = state;
			
			if state {
				
				//create view
				dbg_elements.view_resources = dbg_view("Resource counts",false,10,10,250,400);
				dbg_checkbox(ref_create(___DEBUG_MENU_STRUCT,"tracking_resources"),"Tracking");
				
			}
			else {
				cleanup();
			}
			
		},
		cleanup: function(){
			dbg_view_delete(dbg_elements.view_resources);
			dbg_section_delete(dbg_elements.section_resources);
		},
	};
}
else {
	___DEBUG_MENU_STRUCT = { open: false, accessible: false };
}

