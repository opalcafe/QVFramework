# QVFramework
A GML lang util + some side scripts for testing


## VTest Framework

### How it works
VTest Framework is a set of assert functions to inspect types & that values match an expected output

After importing the files from vtest && vtest-framework, the framework uses gml_pragma to call VTestMain() in vtest-framework directory. All your unit texts should be added to `vtest/unit.`. 

To add a test open `vtest/VTestUnit` there should be a single function called `VTestUnit`. Add a new test by calling `VTestAdd(<script_name>, <test_name>(optional? : string))`


When `VTestMain` fires it will iterate though each test. If any tests fail you will get a dialog error containing the exact test that failed.

#### Note
VTest runs each time you compile your game. Good idea to remove it before production

## QV Language Library for GML + Tokenizer

QVLib is a utility library. At the moment is just contains some debug functions as well as a string parser + string utilities for said parser

### Functions
```
qv_print(message : string) //short hand for show_debug_message();

qv_format(text : string, args : qv_args)  //formats a debug message %s as placeholder for object string representation

qv_args()  
    //shorthand for creating simple arguments

qv_2args(arg1, arg2) 
    //creates qv_args with 2 options

qv_3args(arg1, arg2, arg3) 
    //creates qv_args with 3 options;

qv_4args(arg1, arg2, arg3, arg4) 
    //creates qv_args with 4 options;

qv_5args(arg1, arg2, arg3, arg4, arg5) 
    //creates qv_args with 5 options;

qv_substring(str : string, start : number, length : number)
    //returns a substring of str starting at start with length

```

### Clases


#### QVText
QVText is used for creating a string builder.

```
var builder = new QVText();
builder.append("Hello World");
builder.append(345);
builder.append({
  name : "Some name",
  ahe  : 18
})

vat text = builder.to_string();
qv_print(text);
```
#### Methods
```
to_string():string
    //return the builder to a string

reset()
    //reset builder to empty

append(object : any)
    //append string format of this object to builder

append_bool(boolean)
    //since boolean is a number under the hood. 
    //string(boolean) returns a number rather then 'true' or 'false' use this for string representation of a boolean

padtext(count :number, text) 
    //repeats text 'count' number of times. Useful for space padding 
```


### QVText

QVToken is a helper class used to help write string parsers and tokenizers. 
You pass it a string and using the class methods you can loop over a string to tokenizer it using a character set.

### Create a tokenizer
```
var text = "@tag = 'Hello world'"
var token = new QVToken(text);
```
#### Peek Character
You can peek at the next character in the text by using `.peek_char`. 
Peek will return the next character you are looking at without moving the 'read head' or needle
```
var pound_sign = token.peek_char()
   //pound_sign will equal '@'
``

#### Consume Character
You can consume a character `.consume()` 
it will move the read head 1 character and return you the last symbol before the move
```
var next = token.consume() //next == '#'
var peek_next = token.peek_char() //peek_next == 't' will not move read head
```


#### Looping through text tape
QVToken has an in-built method to help looping through characters. '.alive()'. 
`.alive()` is use din a while loop to check if you have reached the end

```
//will loop through every character and print it
while(token.alive()){
  var symbol = token.consume();
  qv_print(sumbol);
}

#### Parse Token with a charset
You can return a token using a string charset. 
For example lets say you want to get the next number in a string

```
var token_num = new QVToken("2937 rest not a number");
var num = token.next("1234567890"); 
qv_print(num);

var leftover = new QVText();
while(token_num.alive())
  leftover.appen(token_num.consume());
```

### QVToken - Methods
```
.size() //size of text input

.index() //current index in text

.alive() //true will there is still text left

.remaining() //size of remaining characters

.is_whitespace()
  //true is current character is whitespace either '\n', '\t', ' '
  
.text_charset(charset : string)
  //true if the current character matches any character in input string  

.test_string(match : string) 
      //tests if character matches the input using ==
      
 .next(charset : string)
```


