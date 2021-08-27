// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function QVText() constructor {
	__buffer = [0] = "";
	__index = 0;
		
	static to_string = function(){
		var localBuffer = buffer_create(1000, buffer_grow,1);
		
		for(var i=0; i < __index; i++){
			buffer_write(localBuffer, buffer_text,__buffer[i]);
		}
		buffer_write(localBuffer,buffer_string,"");
		buffer_seek(localBuffer, buffer_seek_start, 0);
		var result = buffer_read(localBuffer,buffer_string);
		buffer_delete(localBuffer);
		return result;
	}
	static reset = function(){
		__buffer = [];
		__index = 0;
	}
	
	static append = function(value){
		__buffer[__index++] = string(value);
	}
	static append_bool = function(value){
		if(value == true)
			append("true");
		if(value == false)
			append("false");
	}
	
	static padtext = function(size, text){
		for(var i=0; i < size; i++)
			append(text);
	}
	append("")
}

function qv_substring(str, start, length){
	var builder = new QVText();
	
	for(var i=1; i <= length; i++){
		var index = start + i;
		builder.append(string_char_at(str, index));
	}
	return builder.to_string();
}