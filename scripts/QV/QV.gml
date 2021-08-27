// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function qv_print(object){
	show_debug_message(string(object));
}

function qv_format(text, qv_args){
	var token = new QVToken(text);
	var builder= new QVText();
	var index = 0;
	
	while(token.alive()){
		if(token.peek_char() == "%"){
			token.consume();
			var lchar = token.peek_char();
			if(token.test_number(lchar)){
				var padsize = token.next_number();
				builder.padtext(padsize, " ");
			}
			builder.append(string(qv_args.stack[index++]));
			var type = token.consume();
		}
		else
			builder.append(token.consume());
	}
	show_debug_message(builder.to_string())
}

function qv_args() constructor {
	stack = [];
	index = 0;
	
	static add = function(arg){
		stack[index++] = arg;
		return self;
	}
		
	static forEach = function(callback){
		for(var i=0; i  < index ;i++){
			callback(stack[i]);
		}
	}
}

function qv_2args(p1, p2){
	var args = new qv_args();
	return args.add(p1).add(p2);
}
function qv_3args(p1, p2, p3){
	var args = new qv_args();
	return args.add(p1).add(p2).add(p3);
}
function qv_4args(p1, p2, p3, p4){
	var args = new qv_args();
	return args.add(p1).add(p2).add(p3).add(p4);
}
function qv_5args(p1, p2, p3, p4, p5){
	var args = new qv_args();
	return args.add(p1).add(p2).add(p3).add(p4).add(p5);
}
