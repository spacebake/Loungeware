/*
//-----------------------------------------------------------------------------------------------------------------
// WEAK REF GARBAGE COLLECTOR KATRO HACK| credit to Katsaii (also help from tfg, zandy, net8floz)
//-----------------------------------------------------------------------------------------------------------------
function ___ds_gc_manager() {
    static man = {
        weakRefs : []
    };
    return man;
}

// ----------------------------------------------------------------------------------------------------------------
function ___ds_create(_ds_index, _ds_type) {
	show_message("hellooo");
    var man = ___ds_gc_manager();
    var ref = { ds : _ds_index };
    var weak_ref = weak_ref_create(ref);
    weak_ref.ds = _ds_index;
    weak_ref.dsType = _ds_type;
    array_push(man.weakRefs, weak_ref);
    return ref;
}

// ----------------------------------------------------------------------------------------------------------------
// collects any ds structures that are unreachable
function ___ds_gc_collect() {
    
	var weak_refs = ___ds_gc_manager().weakRefs;
    var n = array_length(weak_refs);
    
	for (var i = n - 1; i >= 0; i -= 1) {
        var weak_ref = weak_refs[i];
        if not (weak_ref_alive(weak_ref)) {
            array_delete(weak_refs, i, 1);
            var ds_type = weak_ref.dsType;
            var ds = weak_ref.ds;
            switch (ds_type) {
            case ds_type_grid:
                ds_grid_destroy(ds);
                break;
            case ds_type_list:
                ds_list_destroy(ds);
                break;
            case ds_type_map:
                ds_map_destroy(ds);
                break;
            case ds_type_priority:
                ds_priority_destroy(ds);
                break;
            case ds_type_queue:
                ds_queue_destroy(ds);
                break;
            case ds_type_stack:
                ds_stack_destroy(ds);
                break;
            default:
                show_error("unknown ds type", true);
                break;
            }
        }
    }
}

//--------------------------------------------------------------------------------------------------------
// macro overrides
//--------------------------------------------------------------------------------------------------------
#macro global ___fake_global

// ds grid override
#macro ds_grid_create ___ds_grid_create_override
#macro ___ds_grid_create_builtin ds_grid_create
function ___ds_grid_create_override(_w, _h){
	var _ds_index = ___ds_grid_create_builtin(_w, _h);
	___ds_create(_ds_index, ds_type_grid);
	return _ds_index;
}

// ds list override
#macro ds_list_create ___ds_list_create_override
#macro ___ds_list_create_builtin ds_list_create
function ___ds_list_create_override(){
	var _ds_index =  ___ds_list_create_builtin();
	___ds_create(_ds_index, ds_type_list);
	return _ds_index;
}

// ds map override
#macro ds_map_create ___ds_map_create_override
#macro ___ds_map_create_builtin ds_map_create
function ___ds_map_create_override(){
	var _ds_index = ___ds_map_create_builtin();
	___ds_create(_ds_index, ds_type_map);
	return _ds_index;
}

// ds priority override
#macro ds_priority_create ___ds_priority_create_override
#macro ___ds_priority_create_builtin ds_priority_create
function ___ds_priority_create_override(){
	var _ds_index = ___ds_priority_create_builtin();
	___ds_create(_ds_index, ds_type_priority);
	return _ds_index;
}

// ds queue override
#macro ds_queue_create ___ds_queue_create_override
#macro ___ds_queue_create_builtin ds_queue_create
function ___ds_queue_create_override(){
	var _ds_index = ___ds_queue_create_builtin();
	___ds_create(_ds_index, ds_type_queue);
	return _ds_index;
}

// ds stack override
#macro ds_stack_create ___ds_stack_create_override
#macro ___ds_stack_create_builtin ds_stack_create
function ___ds_stack_create_override(){
	var _ds_index = ___ds_stack_create_builtin();
	___ds_create(_ds_index, ds_type_stack);
	return _ds_index; 
}
*/

/* Workspaces for Data Structures
 * ------------------------------
 * Kat @katsaii
 */

#macro __WORKSPACE_DS_COLLECTIONS [undefined, [], [], [], [], [], []]
#macro __WORKSPACE_DS_GRID_CREATE ds_grid_create
#macro __WORKSPACE_DS_LIST_CREATE ds_list_create
#macro __WORKSPACE_DS_MAP_CREATE ds_map_create
#macro __WORKSPACE_DS_PRIORITY_CREATE ds_priority_create
#macro __WORKSPACE_DS_QUEUE_CREATE ds_queue_create
#macro __WORKSPACE_DS_STACK_CREATE ds_stack_create
#macro __WORKSPACE_DS_GRID_DESTROY ds_grid_destroy
#macro __WORKSPACE_DS_LIST_DESTROY ds_list_destroy
#macro __WORKSPACE_DS_MAP_DESTROY ds_map_destroy
#macro __WORKSPACE_DS_PRIORITY_DESTROY ds_priority_destroy
#macro __WORKSPACE_DS_QUEUE_DESTROY ds_queue_destroy
#macro __WORKSPACE_DS_STACK_DESTROY ds_stack_destroy
#macro ds_grid_create __workspace_ds_grid_create
#macro ds_list_create __workspace_ds_list_create
#macro ds_map_create __workspace_ds_map_create
#macro ds_priority_create __workspace_ds_priority_create
#macro ds_queue_create __workspace_ds_queue_create
#macro ds_stack_create __workspace_ds_stack_create
#macro ds_grid_destroy __workspace_ds_grid_destroy
#macro ds_list_destroy __workspace_ds_list_destroy
#macro ds_map_destroy __workspace_ds_map_destroy
#macro ds_priority_destroy __workspace_ds_priority_destroy
#macro ds_queue_destroy __workspace_ds_queue_destroy
#macro ds_stack_destroy __workspace_ds_stack_destroy

/// @desc Returns the workspace controller.
function __workspace_controller() {
    static workspace = {
        enabled : false,
        ids : [undefined, [], [], [], [], [], []]
    };
    return workspace;
}

/// @desc Registers a data structure with this type for garbage collection.
/// @param {real} id The id of the data structure to register.
/// @param {real} type The type of the data structure.
function __workspace_register(_ds, _ds_type) {
    var workspace = __workspace_controller();
    if (workspace.enabled) {
        var ids = workspace.ids[_ds_type];
        ids[@ _ds] = true;
    }
    return _ds;
}

/// @desc Unregisters a data structure with this type.
/// @param {real} id The ID of the data structure to unregister.
/// @param {real} type The type of the data structure.
function __workspace_unregister(_ds, _ds_type) {
    var workspace = __workspace_controller();
    if not (workspace.enabled) {
        return;
    }
    var ids = workspace.ids[_ds_type];
    ids[@ _ds] = false;
}

/// @desc Starts a new workspace.
function workspace_begin() {
    var workspace = __workspace_controller();
    if (workspace.enabled) {
        show_error("a workspace already exists", true);
        return;
    }
    workspace.enabled = true;
    workspace.ids = __WORKSPACE_DS_COLLECTIONS;
}

/// @desc Ends the current workspace and destroys any marked data structures.
function workspace_end() {
    var workspace = __workspace_controller();
    if not (workspace.enabled) {
        return;
    }
    workspace.enabled = false;
    var ids = workspace.ids;
    for (var i = 6; i > 0; i -= 1) {
        var my_ids = ids[i];
        for (var j = array_length(my_ids) - 1; j >= 0; j -= 1) {
            var exists = my_ids[j];
            if (is_numeric(exists) && exists) {
                switch (i) {
                case ds_type_grid:
                    __WORKSPACE_DS_GRID_DESTROY(j);
                    break;
                case ds_type_list:
                    __WORKSPACE_DS_LIST_DESTROY(j);
                    break;
                case ds_type_map:
                    __WORKSPACE_DS_MAP_DESTROY(j);
                    break;
                case ds_type_priority:
                    __WORKSPACE_DS_PRIORITY_DESTROY(j);
                    break;
                case ds_type_queue:
                    __WORKSPACE_DS_QUEUE_DESTROY(j);
                    break;
                case ds_type_stack:
                    __WORKSPACE_DS_STACK_DESTROY(j);
                    break;
                default:
                    show_error("unknown ds_type " + string(i), true);
                    break;
                }
            }
        }
    }
}

/// @desc Creates a new grid data structure.
/// @param {real} w The width of the grid.
/// @param {real} h The height of the grid.
function __workspace_ds_grid_create(_w, _h) {
    return __workspace_register(__WORKSPACE_DS_GRID_CREATE(_w, _h), ds_type_grid);
}

/// @desc Creates a new list data structure.
function __workspace_ds_list_create() {
    return __workspace_register(__WORKSPACE_DS_LIST_CREATE(), ds_type_list);
}

/// @desc Creates a new map data structure.
function __workspace_ds_map_create() {
    return __workspace_register(__WORKSPACE_DS_MAP_CREATE(), ds_type_map);
}

/// @desc Creates a new priority queue data structure.
function __workspace_ds_priority_create() {
    return __workspace_register(__WORKSPACE_DS_PRIORITY_CREATE(), ds_type_priority);
}

/// @desc Creates a new queue data structure.
function __workspace_ds_queue_create() {
    return __workspace_register(__WORKSPACE_DS_QUEUE_CREATE(), ds_type_queue);
}

/// @desc Creates a new stack data structure.
function __workspace_ds_stack_create() {
    return __workspace_register(__WORKSPACE_DS_STACK_CREATE(), ds_type_stack);
}

/// @desc Destroys a grid data structure with this ID.
/// @param {real} id The ID of the data structure to destroy.
function __workspace_ds_grid_destroy(_ds) {
    __WORKSPACE_DS_GRID_DESTROY(_ds);
    __workspace_unregister(_ds, ds_type_grid);
}

/// @desc Destroys a list data structure with this ID.
/// @param {real} id The ID of the data structure to destroy.
function __workspace_ds_list_destroy(_ds) {
    __WORKSPACE_DS_LIST_DESTROY(_ds);
    __workspace_unregister(_ds, ds_type_list);
}

/// @desc Destroys a map data structure with this ID.
/// @param {real} id The ID of the data structure to destroy.
function __workspace_ds_map_destroy(_ds) {
    __WORKSPACE_DS_MAP_DESTROY(_ds);
    __workspace_unregister(_ds, ds_type_map);
}

/// @desc Destroys a priority queue data structure with this ID.
/// @param {real} id The ID of the data structure to destroy.
function __workspace_ds_priority_destroy(_ds) {
    __WORKSPACE_DS_PRIORITY_DESTROY(_ds);
    __workspace_unregister(_ds, ds_type_priority);
}

/// @desc Destroys a queue data structure with this ID.
/// @param {real} id The ID of the data structure to destroy.
function __workspace_ds_queue_destroy(_ds) {
    __WORKSPACE_DS_QUEUE_DESTROY(_ds);
    __workspace_unregister(_ds, ds_type_queue);
}

/// @desc Destroys a stack data structure with this ID.
/// @param {real} id The ID of the data structure to destroy.
function __workspace_ds_stack_destroy(_ds) {
    __WORKSPACE_DS_STACK_DESTROY(_ds);
    __workspace_unregister(_ds, ds_type_stack);
}