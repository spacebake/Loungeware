

/* Workspaces for Data Structures
 * ------------------------------
 * Kat @katsaii
 */

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

/// @desc Represents all possible dynamic resource types.
enum __WorkspaceDsTypes {
    GRID,
    LIST,
    MAP,
    PRIORITY,
    QUEUE,
    STACK,
    __COUNT__
}

/// @desc Returns the workspace controller.
function __workspace_controller() {
    static workspace = {
        enabled : false,
        ids : undefined,
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
    if (!workspace.enabled) {
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
    var ids = array_create(__WorkspaceDsTypes.__COUNT__, undefined);
    workspace.ids = ids;
    for (var i = __WorkspaceDsTypes.__COUNT__ - 1; i > 0; i -= 1) {
        ids[@ i] = [];
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
        var my_ids = ids[i];
        for (var j = array_length(my_ids) - 1; j >= 0; j -= 1) {
            var exists = my_ids[j];
            if (is_numeric(exists) && exists) {
                switch (i) {
                case __WorkspaceDsTypes.GRID:
                    __WORKSPACE_DS_GRID_DESTROY(j);
                    break;
                case __WorkspaceDsTypes.LIST:
                    __WORKSPACE_DS_LIST_DESTROY(j);
                    break;
                case __WorkspaceDsTypes.MAP:
                    __WORKSPACE_DS_MAP_DESTROY(j);
                    break;
                case __WorkspaceDsTypes.PRIORITY:
                    __WORKSPACE_DS_PRIORITY_DESTROY(j);
                    break;
                case __WorkspaceDsTypes.QUEUE:
                    __WORKSPACE_DS_QUEUE_DESTROY(j);
                    break;
                case __WorkspaceDsTypes.STACK:
                    __WORKSPACE_DS_STACK_DESTROY(j);
                    break;
                default:
                    show_error("unknown resource type " + string(i), true);
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

/// @desc Destroys a grid data structure with this ID.
/// @param {real} id The ID of the data structure to destroy.
function __workspace_ds_grid_destroy(_ds) {
    __WORKSPACE_DS_GRID_DESTROY(_ds);
    __workspace_unregister(_ds, __WorkspaceDsTypes.GRID);
}

/// @desc Destroys a list data structure with this ID.
/// @param {real} id The ID of the data structure to destroy.
function __workspace_ds_list_destroy(_ds) {
    __WORKSPACE_DS_LIST_DESTROY(_ds);
    __workspace_unregister(_ds, __WorkspaceDsTypes.LIST);
}

/// @desc Destroys a map data structure with this ID.
/// @param {real} id The ID of the data structure to destroy.
function __workspace_ds_map_destroy(_ds) {
    __WORKSPACE_DS_MAP_DESTROY(_ds);
    __workspace_unregister(_ds, __WorkspaceDsTypes.MAP);
}

/// @desc Destroys a priority queue data structure with this ID.
/// @param {real} id The ID of the data structure to destroy.
function __workspace_ds_priority_destroy(_ds) {
    __WORKSPACE_DS_PRIORITY_DESTROY(_ds);
    __workspace_unregister(_ds, __WorkspaceDsTypes.PRIORITY);
}

/// @desc Destroys a queue data structure with this ID.
/// @param {real} id The ID of the data structure to destroy.
function __workspace_ds_queue_destroy(_ds) {
    __WORKSPACE_DS_QUEUE_DESTROY(_ds);
    __workspace_unregister(_ds, __WorkspaceDsTypes.QUEUE);
}

/// @desc Destroys a stack data structure with this ID.
/// @param {real} id The ID of the data structure to destroy.
function __workspace_ds_stack_destroy(_ds) {
    __WORKSPACE_DS_STACK_DESTROY(_ds);
    __workspace_unregister(_ds, __WorkspaceDsTypes.STACK);
}