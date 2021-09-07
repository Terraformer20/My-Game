// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function print() {
	var _string = ""
	for (var i = 0; i < argument_count; i++) {
		_string += string(argument[i])
	}
	show_debug_message(_string)
}

function str() {
	var _string = ""
	for (var i = 0; i < argument_count; i++) {
		_string += string(argument[i])
	}
	return _string;
}

function bubbleSort(list) {
	var listSize = array_length(list);
	for (var i = 0; i < listSize - 1; i += 1) {
		for (var j = 0; j < listSize - i - 1; j += 1) {
			if (list[j].currStat.spd < list[j+1].currStat.spd) {
				var temp = list[j];
				list[j] = list[j+1];
				list[j+1] = temp;
			}
		}
	}
	return list;
}

// Returns the first index of element in an array or -1 if none found
function indexOf(array, element) {
	for (var i = 0; i < array_length(array); i += 1) {
		if (array[i] == element) {
			return i;
		}
	}
	return -1;
}

// The problem is that it copies too much, it doesn't need to copy your items or all your skills or anything like that
function deep_copy(ref) {
	///found this gem on the interwebs MIT license 
	/// @function                       deep_copy(ref)
	/// @param {T} ref                  Thing to deep copy
	/// @returns {T}                    New array, or new struct, or new instance of the class, anything else (real / string / etc.) will be returned as-is
	/// @description                    Returns a deep recursive copy of the provided array / struct / constructed struct
	var ref_new;
	
	if (is_array(ref)) {
		ref_new = array_create(array_length(ref));
	
		var length = array_length(ref_new);
		
		for (var i = 0; i < length; i++) {
			ref_new[i] = deep_copy(ref[i]);
		}
		return ref_new;
	}
	else if (is_struct(ref)) {
		var base = instanceof(ref);
        
		switch (base) {
			case "struct":
			case "weakref":
				ref_new = {};
				break;
				
			default:
				var constr = method(undefined, asset_get_index(base));
				ref_new = new constr();
		}
        
		var names = variable_struct_get_names(ref);
		var length = variable_struct_names_count(ref);
        
		for (var i = 0; i < length; i++) {
			var name = names[i];
			variable_struct_set(ref_new, name, deep_copy(variable_struct_get(ref, name)));
		}
        
		return ref_new;
	} else {
		return ref;
	}
}

function shallow_copy(ref) {
	var ref_new;
	print(ref);
	if (is_struct(ref)) {
		var base = instanceof(ref);
        
		switch (base) {
			case "struct":
			case "weakref":
				ref_new = {};
				break;
				
			default:
				var constr = method(undefined, asset_get_index(base));
				ref_new = new constr();
		}
        
		var names = variable_struct_get_names(ref);
		var length = variable_struct_names_count(ref);
        
		for (var i = 0; i < length; i++) {
			var name = names[i];
			print(name);
			variable_struct_set(ref_new, name, shallow_copy(variable_struct_get(ref, name)));
		}
        
		return ref_new;
	} else {
		return ref;
	}
}