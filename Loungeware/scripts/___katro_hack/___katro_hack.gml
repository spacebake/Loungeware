

/* Workspaces for Data Structures
 * ------------------------------
 * Kat @katsaii
 *
 * fixes by antidissmist 7/16/24
 * 
 * There are other types of dynamic resources, but this will do for now :P
 * https://manual.gamemaker.io/beta/en/index.htm?#t=GameMaker_Language%2FGML_Overview%2FData_Types.htm
 */

//create
#macro __WORKSPACE_DS_GRID_CREATE ds_grid_create
#macro __WORKSPACE_DS_LIST_CREATE ds_list_create
#macro __WORKSPACE_DS_MAP_CREATE ds_map_create
#macro __WORKSPACE_DS_PRIORITY_CREATE ds_priority_create
#macro __WORKSPACE_DS_QUEUE_CREATE ds_queue_create
#macro __WORKSPACE_DS_STACK_CREATE ds_stack_create
#macro __WORKSPACE_PART_SYSTEM_CREATE part_system_create
#macro __WORKSPACE_PART_SYSTEM_CREATE_LAYER part_system_create_layer
#macro __WORKSPACE_PART_TYPE_CREATE part_type_create
#macro __WORKSPACE_SURFACE_CREATE surface_create
//destroy
#macro __WORKSPACE_DS_GRID_DESTROY ds_grid_destroy
#macro __WORKSPACE_DS_LIST_DESTROY ds_list_destroy
#macro __WORKSPACE_DS_MAP_DESTROY ds_map_destroy
#macro __WORKSPACE_DS_PRIORITY_DESTROY ds_priority_destroy
#macro __WORKSPACE_DS_QUEUE_DESTROY ds_queue_destroy
#macro __WORKSPACE_DS_STACK_DESTROY ds_stack_destroy
#macro __WORKSPACE_PART_SYSTEM_DESTROY part_system_destroy
#macro __WORKSPACE_PART_TYPE_DESTROY part_type_destroy
#macro __WORKSPACE_SURFACE_FREE surface_free
//create
#macro ds_grid_create __workspace_ds_grid_create
#macro ds_list_create __workspace_ds_list_create
#macro ds_map_create __workspace_ds_map_create
#macro ds_priority_create __workspace_ds_priority_create
#macro ds_queue_create __workspace_ds_queue_create
#macro ds_stack_create __workspace_ds_stack_create
#macro part_system_create __workspace_part_system_create
#macro part_system_create_layer __workspace_part_system_create_layer
#macro part_type_create __workspace_part_type_create
#macro surface_create __workspace_surface_create
//destroy
#macro ds_grid_destroy __workspace_ds_grid_destroy
#macro ds_list_destroy __workspace_ds_list_destroy
#macro ds_map_destroy __workspace_ds_map_destroy
#macro ds_priority_destroy __workspace_ds_priority_destroy
#macro ds_queue_destroy __workspace_ds_queue_destroy
#macro ds_stack_destroy __workspace_ds_stack_destroy
#macro part_system_destroy __workspace_part_system_destroy
#macro part_type_destroy __workspace_part_type_destroy
#macro surface_free __workspace_surface_free


/// @desc Represents all possible dynamic resource types.
enum __WorkspaceDsTypes {
    GRID,
    LIST,
    MAP,
    PRIORITY,
    QUEUE,
    STACK,
    PART_SYS,
    PART_TYPE,
    SURFACE,
    __COUNT__
}

/// @desc Returns the workspace controller.
function __workspace_controller() {
    static workspace = {
        enabled : false,
        ids : undefined, ///ex: [ { "4": <ref blah 4>, "7": <ref blah 7> }, ... ]
    };
    return workspace;
}

/// @desc Registers a data structure with this type for garbage collection.
/// @param {id} id The id of the data structure to register.
/// @param {real} type The type of the data structure.
function __workspace_register(_ds, _ds_type) {
    var workspace = __workspace_controller();
    if (workspace.enabled) {
        var ids = workspace.ids[_ds_type];
		ids[$ __workspace_ds_get_id(_ds)] = _ds;
    }
    return _ds;
}


/// @desc Returns whether a data structure is registered, and must exist
/// @param {id} id The id of the data structure
/// @param {real} type The type of the data structure.
/*function __workspace_ds_registered(_ds, _ds_type) {
    var workspace = __workspace_controller();
    if (!workspace.enabled) {
        return false;
    }
    var ids = workspace.ids[_ds_type];
	var _ds_ref = ids[$ __workspace_ds_get_id(_ds)]; // <ref blah 4> or <undefined>
	return !is_undefined(_ds_ref) && typeof(_ds_ref)=="ref";
}*/

/// @desc Unregisters a data structure with this type.
/// @param {id} id The ID of the data structure to unregister.
/// @param {real} type The type of the data structure.
function __workspace_unregister(_ds, _ds_type) {
    var workspace = __workspace_controller();
    if (!workspace.enabled) {
        return;
    }
    var ids = workspace.ids[_ds_type];
	ids[$ __workspace_ds_get_id(_ds)] = undefined;
}

/// @desc Gets the numeric id of a data structure
/// @param {id} id The ID of the data structure
/// @returns string
function __workspace_ds_get_id(_ds) {
	// "ref blah 4" -> "4"
	return string_digits(string(_ds));
}

/// @desc Starts a new workspace.
function workspace_begin() {
    var workspace = __workspace_controller();
    if (workspace.enabled) {
        show_error("a workspace already exists", true);
        return;
    }
    workspace.enabled = true;
    var ids = array_create(__WorkspaceDsTypes.__COUNT__, undefined);
    workspace.ids = ids;
    for (var i = __WorkspaceDsTypes.__COUNT__ - 1; i > 0; i -= 1) {
        ids[@ i] = {};
    }
}

/// @desc Ends the current workspace and destroys any marked data structures.
function workspace_end() {
    var workspace = __workspace_controller();
    if (!workspace.enabled) {
        return;
    }
    workspace.enabled = false;
    var ids = workspace.ids;
    for (var i = __WorkspaceDsTypes.__COUNT__ - 1; i > 0; i -= 1) {
        var ids_struct = ids[i];
		var id_names = struct_get_names(ids_struct); // [ "3", "4", ... ]
		var names_len = array_length(id_names);
        for (var j = names_len - 1; j >= 0; j -= 1) {
			var name = id_names[j]; // "4"
			var numeric_id = real(name);
			var _ds_ref = ids_struct[$ name]; // ref blah 4
			
			if !is_undefined(_ds_ref) && typeof(_ds_ref)=="ref" {
				
                switch (i) {
                case __WorkspaceDsTypes.GRID:
                    __WORKSPACE_DS_GRID_DESTROY(_ds_ref);
                    break;
                case __WorkspaceDsTypes.LIST:
                    __WORKSPACE_DS_LIST_DESTROY(_ds_ref);
                    break;
                case __WorkspaceDsTypes.MAP:
                    __WORKSPACE_DS_MAP_DESTROY(_ds_ref);
                    break;
                case __WorkspaceDsTypes.PRIORITY:
                    __WORKSPACE_DS_PRIORITY_DESTROY(_ds_ref);
                    break;
                case __WorkspaceDsTypes.QUEUE:
                    __WORKSPACE_DS_QUEUE_DESTROY(_ds_ref);
                    break;
                case __WorkspaceDsTypes.STACK:
                    __WORKSPACE_DS_STACK_DESTROY(_ds_ref);
                    break;
                case __WorkspaceDsTypes.PART_SYS:
                    __WORKSPACE_PART_SYSTEM_DESTROY(_ds_ref);
                    break;
                case __WorkspaceDsTypes.PART_TYPE:
                    __WORKSPACE_PART_TYPE_DESTROY(_ds_ref);
                    break;
                case __WorkspaceDsTypes.SURFACE:
                    __WORKSPACE_SURFACE_FREE(_ds_ref);
                    break;
                default:
                    show_error("unknown resource type " + string(i), true);
                    break;
                }
            }
        }
    }
}


#region create

/// @desc Creates a new grid data structure.
/// @param {real} w The width of the grid.
/// @param {real} h The height of the grid.
function __workspace_ds_grid_create(_w, _h) {
    return __workspace_register(__WORKSPACE_DS_GRID_CREATE(_w, _h), __WorkspaceDsTypes.GRID);
}

/// @desc Creates a new list data structure.
function __workspace_ds_list_create() {
    return __workspace_register(__WORKSPACE_DS_LIST_CREATE(), __WorkspaceDsTypes.LIST);
}

/// @desc Creates a new map data structure.
function __workspace_ds_map_create() {
    return __workspace_register(__WORKSPACE_DS_MAP_CREATE(), __WorkspaceDsTypes.MAP);
}

/// @desc Creates a new priority queue data structure.
function __workspace_ds_priority_create() {
    return __workspace_register(__WORKSPACE_DS_PRIORITY_CREATE(), __WorkspaceDsTypes.PRIORITY);
}

/// @desc Creates a new queue data structure.
function __workspace_ds_queue_create() {
    return __workspace_register(__WORKSPACE_DS_QUEUE_CREATE(), __WorkspaceDsTypes.QUEUE);
}

/// @desc Creates a new stack data structure.
function __workspace_ds_stack_create() {
    return __workspace_register(__WORKSPACE_DS_STACK_CREATE(), __WorkspaceDsTypes.STACK);
}

/// @desc Creates a new particle system data structure.
function __workspace_part_system_create() {
    return __workspace_register(__WORKSPACE_PART_SYSTEM_CREATE(), __WorkspaceDsTypes.PART_SYS);
}

/// @desc Creates a new particle system data structure.
/// @param {any} layer_id_or_name The layer to create the particle system on.
/// @param {bool} persistent Whether to automatically manage the particle system.
function __workspace_part_system_create_layer(_layer, _persistent) {
    if (is_numeric(_persistent) && _persistent) {
        return __WORKSPACE_PART_SYSTEM_CREATE_LAYER(_layer, _persistent);
    }
    return __workspace_register(__WORKSPACE_PART_SYSTEM_CREATE_LAYER(_layer, false), __WorkspaceDsTypes.PART_SYS);
}

/// @desc Creates a new particle type data structure.
function __workspace_part_type_create() {
    return __workspace_register(__WORKSPACE_PART_TYPE_CREATE(), __WorkspaceDsTypes.PART_TYPE);
}

/// @desc Creates a new surface.
/// @param {real} width The width of the surface.
/// @param {real} height The height of the surface.
/// @param {Constant.SurfaceFormatType} format The data format of the surface.
function __workspace_surface_create(w,h,format=surface_rgba8unorm) {
    return __workspace_register(__WORKSPACE_SURFACE_CREATE(w,h,format), __WorkspaceDsTypes.SURFACE);
}

#endregion


#region destroy
//we must check that each data structure exists before destroying it, because some will crash

/// @desc Destroys a grid data structure with this ID.
/// @param {id} id The ID of the data structure to destroy.
function __workspace_ds_grid_destroy(_ds) {
	if ds_exists(_ds,ds_type_grid) {
	    __WORKSPACE_DS_GRID_DESTROY(_ds);
	    __workspace_unregister(_ds, __WorkspaceDsTypes.GRID);
	}
}

/// @desc Destroys a list data structure with this ID.
/// @param {id} id The ID of the data structure to destroy.
function __workspace_ds_list_destroy(_ds) {
	if ds_exists(_ds,ds_type_list) {
	    __WORKSPACE_DS_LIST_DESTROY(_ds);
	    __workspace_unregister(_ds, __WorkspaceDsTypes.LIST);
	}
}

/// @desc Destroys a map data structure with this ID.
/// @param {id} id The ID of the data structure to destroy.
function __workspace_ds_map_destroy(_ds) {
	if ds_exists(_ds,ds_type_map) {
	    __WORKSPACE_DS_MAP_DESTROY(_ds);
	    __workspace_unregister(_ds, __WorkspaceDsTypes.MAP);
	}
}

/// @desc Destroys a priority queue data structure with this ID.
/// @param {id} id The ID of the data structure to destroy.
function __workspace_ds_priority_destroy(_ds) {
	if ds_exists(_ds,ds_type_priority) {
	    __WORKSPACE_DS_PRIORITY_DESTROY(_ds);
	    __workspace_unregister(_ds, __WorkspaceDsTypes.PRIORITY);
	}
}

/// @desc Destroys a queue data structure with this ID.
/// @param {id} id The ID of the data structure to destroy.
function __workspace_ds_queue_destroy(_ds) {
	if ds_exists(_ds,ds_type_queue) {
	    __WORKSPACE_DS_QUEUE_DESTROY(_ds);
	    __workspace_unregister(_ds, __WorkspaceDsTypes.QUEUE);
	}
}

/// @desc Destroys a stack data structure with this ID.
/// @param {id} id The ID of the data structure to destroy.
function __workspace_ds_stack_destroy(_ds) {
	if ds_exists(_ds,ds_type_stack) {
	    __WORKSPACE_DS_STACK_DESTROY(_ds);
	    __workspace_unregister(_ds, __WorkspaceDsTypes.STACK);
	}
}

/// @desc Destroys a particle system data structure with this ID.
/// @param {id} id The ID of the data structure to destroy.
function __workspace_part_system_destroy(_ds) {
	if part_system_exists(_ds) {
	    __WORKSPACE_PART_SYSTEM_DESTROY(_ds);
	    __workspace_unregister(_ds, __WorkspaceDsTypes.PART_SYS);
	}
}

/// @desc Destroys a particle type data structure with this ID.
/// @param {id} id The ID of the data structure to destroy.
function __workspace_part_type_destroy(_ds) {
	if part_type_exists(_ds) {
		__WORKSPACE_PART_TYPE_DESTROY(_ds);
		__workspace_unregister(_ds, __WorkspaceDsTypes.PART_TYPE);
	}
}

/// @desc Frees a surface with this ID.
/// @param {id} id The ID of the surface to free.
function __workspace_surface_free(_ds) {
	if surface_exists(_ds) {
		__WORKSPACE_SURFACE_FREE(_ds);
		__workspace_unregister(_ds, __WorkspaceDsTypes.SURFACE);
	}
}


#endregion

