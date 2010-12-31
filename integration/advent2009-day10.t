# http://perl6advent.wordpress.com/2009/12/10/day-10-a-regex-story/

use v6;
use Test;

plan 5;

grammar Inventory {
    regex product { \d+ }
    regex quantity { \d+ }
    regex color { \S+ }
    regex description { \N* }
    regex TOP { ^^ <product> \s+ <quantity>  \s+
                [
                | <description> \s+ '(' \s* <color> \s*  ')'
                | <color> \s+ <description>
                ]
                $$
    }
}


nok Inventory.parse('abc') , 'Incorrect line does not parse';

ok Inventory.parse('1234 3 red This is a description') , "Standard line parsed ok";
is ($<product>,$<quantity>,$<color>,$<description>) , ('1234' ,'3','red','This is a description') , "Result OK";

ok Inventory.parse('1234 3 This is a description (red)') , "Color in description";
is ($<product>,$<quantity>,$<color>,$<description>) , ('1234' ,'3','red','This is a description') , "Result OK";


done;
