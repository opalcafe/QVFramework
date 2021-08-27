

global.unitTests = [0];
global.unitTestsIndex = 0;


function VTestMain(){
	try{
		VTestUnit();
	}catch(e){
		show_debug_message(e);
		throw "\n\n@VTest >> VTestUnit() Function Script does not exists.\nThis is the entry point to VTestFramework\n\n"
	}
	//attempt to Run Tests 
	for(i=0; i < global.unitTestsIndex; i++){
		test = global.unitTests[i];
		
		unitName = test.caller;
		show_debug_message("@VTest >> Running Unit Test: (" + unitName + ")")
		
		try{
			test.unit();
		}catch(e){
			throw "\n\nTest Unit Failed @Unit >> ("+ unitName +")\n\n" + string(e);
		}
	}
	show_debug_message("@VTest >> Success All Tests Passed")
}

function VTestAdd(test, name){
	if(is_undefined(name))
		name = "--Unspecified Test Name @ Index: " + string(global.unitTestsIndex)
	global.unitTests[global.unitTestsIndex++] = {
		unit : test,
		caller : name
	}
}
function vprint(message){
	show_debug_message("!VPrint:\n" + message);
}

function vassertTrue(value, message){
	if(is_undefined(message))
		message = "unspecified";
	if(value == false){
		throw "\n\nVTest Error\n\nVTest: Assertion Failed:\n\nVTest.ASSERT @>> " + message + "\n\n";
	}
}
function vassertFalse(value, message){
	vassertTrue(value == false, message);
}
function vassertBool(value, expected, message){
	vtypeBool(value, "Value not a boolean: " + message);
	vtypeBool(expected, "Expected not a boolean: " + message);
	vassertTrue(value == expected, message);
}
function vassert_number(value, expected, message){
	vtypeNumber(value, "Value not Number: " + message);
	vtypeNumber(expected, "Expected not a Number" + message);
	vassertTrue(value == expected, message);
}
function vassertString(value, expected, message){
	vtypeString(value, "Value is not a String: " + message);
	vtypeString(expected, "Expected is not a String" + message);
	vassertTrue(value == expected, message);
}
function vassertType(value, expected, message){
	if(value == true || value == false || expected == true || expected == false){
		vtypeBool(expected, message);
		vtypeBool(value, message);
	}
	vassertTrue(typeof(value) == typeof(expected),message);
}
//Type Asserts
function vtypeNumber(value, message){
	vassertTrue(typeof(value) == "number", message);
}
function vtypeString(value, message){
	vassertTrue(typeof(value) == "string",message);
}
function vtypeBool(value, message){
	vassertTrue(value == true || value == false, message);
}
function vtypeArray(value, message){
	vassertTrue(typeof(value) == "array", message);
}
function vtypeStruct(value, message){
	vassertTrue(typeof(value) == "struct", message);
}

function vassertDefined(value, message){
	vassertFalse(is_undefined(value), message);
}

function vassertUndefined(value, message){
	vassertTrue(is_undefined(value), message);
}

function vexists(value, message){
	if(is_undefined(message)) message = "unspecified";
	vassertDefined(value, "Required: (" + message +")");
}
function vundef(value, message){
	vassertTrue(is_undefined(value), message);
}

function vnumberRange(value, lower, upper, message){
	vtypeNumber(value, "Value is not a number: " + message);
	vtypeNumber(lower, "Lower is not a number: " + message);
	vtypeNumber(upper, "Upper is not a number: " + message);
	vassertTrue(value >= lower && value <= upper,message);
}
function vrange(value, lower, upper, message){
	vnumberRange(value, lower, upper, message);
}

function vassertArray(checkArray, expectedArray, message){
	lenCheck = array_length(checkArray);
	lenExpect = array_length(expectedArray);
	vassertNumber(lenCheck, lenExpect, message);
	for(i =0; i < lenCheck; i++){
		c1 = checkArray[i];
		e1 = expectedArray[i];
		vassertType(c1, e1, "Not same type: " + message);
		vassertTrue(c1 == e1, message);
	}
}
function vassertArrayType(checkArray, sample, message){
	lenCheck = array_length(checkArray);
	for(i = 0; i < lenCheck; i++){
		vassertType(checkArray[i], sample, message);
	}

}

function vassertThrow(funct, doesThrow, message){
	thrown = false
	try{
		funct();
	}catch(e){
		thrown = true;
	}
	vassertBool(thrown, doesThrow,message);
}
