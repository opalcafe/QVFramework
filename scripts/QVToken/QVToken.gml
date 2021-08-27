// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
global.qv_regclass_number = "1234567890";
global.qv_regclass_alpha = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";


function QVToken(text) constructor {
	__text = text;
	__index = 1
	__length = string_length(text);
	
	static peek_char = function() {
		return string_char_at(__text, __index);
	}
	static consume = function(){
		return string_char_at(__text,__index++);
	}
	static size = function(){
		return __length;
	}
	static index = function(){
		return __index;
	}
	
	static alive = function(){
		return __index <= __length;
	}
	
	static remaining = function(){
		return __length - __index + 1;
	}
	
	static is_whitespace = function(){
		var next = peek_char();
		return next == " " || next == "\n" || next == "\t";
	}
	static test_charset = function(charset){
		var clen = string_length(charset);
		for(var i= 0; i <= clen; i++){
			var ichar = string_char_at(charset, i);
			if(ichar == peek_char())
				return true;
		}
		return false;
	}
	
	static test_string = function(text){
		return peek_char() == text;
	}
	static test_number = function(){
		return test_charset(global.qv_regclass_number);
	}
	
	static skip_whitespace = function(){
		while(alive() && is_whitespace()){
			consume();
		}
	}
	
	static next = function(charset){
		var builder= new QVText();
		while(alive() && test_charset(charset)){
			var achar = consume();
			qv_print(achar);
			builder.append(achar);
		}
		return builder.to_string();
	}
	
	static next_alpha = function(){
		skip_whitespace();
		return next(global.qv_regclass_alpha);
	}
	
	static next_number = function(){
		skip_whitespace();
		var tk_num = next(global.qv_regclass_number);
		return real(tk_num);
	}
	
}