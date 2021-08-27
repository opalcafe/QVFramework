// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function Test_Print(){
	
	qv_format("hello %20s", qv_2args("world", 123));
	
	
	
	vassertString(434, "3449", "is it a strintg");

}