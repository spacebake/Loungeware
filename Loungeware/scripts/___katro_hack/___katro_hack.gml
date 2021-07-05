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
