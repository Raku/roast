# http://perl6advent.wordpress.com/2009/12/21/day-21-grammars-and-actions/

use v6;
use Test;

plan 2;

use lib 't/spec/packages';

class Question::Answer {
    has $.text is rw;
    has Bool $.correct is rw;
}
class Question {
    has $.text is rw;
    has $.type is rw;
    has Question::Answer @.answers is rw;
    method ask {
        my %hints = (
            pickmany => "Choose all that are true",
            pickone => "Choose the one item that is correct",
        );
        say "\n{%hints{$.type}}\n";
        say $.text;
        for @.answers.kv -> $i, $a {
            say "$i) {$a.text}";
        }
        print "> ";
        my $line = $*IN.get();
        my @answers = $line.comb(/<digit>+/)>>.Int.sort;
        my @correct = @.answers.kv.map({ $^value.correct ?? $^key !! () });
        if @correct ~~ @answers {
            say "Yay, you got it right!";
            return 1;
        } else {
            say "Oops... you got it wrong. :(";
            return 0;
        }
    }
}

 grammar Question::Grammar {
    token TOP {
        \n*
        <question>+
    }
    token question {
        <header>
        <answer>+
    }
    token header {
        ^^ $<type>=['pickone'|'pickmany'] ':' \s+ $<text>=[\N*] \n
    }
    token answer {
        ^^ \s+ $<correct>=['ac'|'ai'] ':' \s+ $<text>=[\N*] \n
    }
}

class Question::Actions {
    method TOP($/) {
        make $<question>».ast;
    }
    method question($/) {
        make Question.new(
            text => ~$<header><text>,
            type => ~$<header><type>,
            answers => $<answer>».ast,
        );
    }
    method answer($/) {
        make Question::Answer.new(
            correct => ~$<correct> eq 'ac',
            text => ~$<text>,
        );
    }
}

my $text = Q {
pickmany: Which items are food?
    ac: Rice
    ac: Orange
    ac: Mushroom
    ai: Shoes
pickone: Which item is a color?
    ac: Orange
    ai: Shoes
    ai: Mushroom
    ai: Rice
};

my $output = "";
my @input = '0 1 2', '1';

{

    temp $*IN = class {
        method get(*@args) {
            return @input.shift;
        }
    }

    temp $*OUT = class {
        method print(*@args) {
            $output ~= @args.join;
        }
    }

    my $actions = Question::Actions.new();
    my @questions = Question::Grammar.parse($text, :actions($actions)).ast.flat;
    my @results = @questions.map(*.ask);

    say "\nFinal score: " ~ [+] @results;
}

is_deeply @input, [], 'questions consumed';
is $output.subst("\r", "", :g), ("\n" ~ q:to"END-OUT").subst("\r", "", :g), 'questions output';
Choose all that are true

Which items are food?
0) Rice
1) Orange
2) Mushroom
3) Shoes
> Yay, you got it right!

Choose the one item that is correct

Which item is a color?
0) Orange
1) Shoes
2) Mushroom
3) Rice
> Oops... you got it wrong. :(

Final score: 1
END-OUT
