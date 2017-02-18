use v6;
use Test;

plan 16;

#?rakudo skip 'macros RT #124978'
{
    use experimental :macros;
    my $var = 0;
    ok(EVAL('macro circumfix:["<!--","-->"] ($text) is parsed / .*? / { "" }; <!-- $var = 1; -->; $var == 0;'), 'circumfix macro {"",""}');
    ok(EVAL('macro circumfix:«<!-- -->» ($text) is parsed / .*? / { "" }; <!-- $var = 1; -->; $var == 0;'), 'circumfix macro «»');
}

{
    sub circumfix:<<` `>>(*@args) { @args.join('-') }
    is `3, 4, "f"`, '3-4-f', 'slurpy circumfix:<<...>> works';
    is ` 3, 4, "f" `, '3-4-f', 'slurpy circumfix:<<...>> works, allows spaces';
    is EVAL('` 3, 4, "f" `'),'3-4-f','lexically defined circumfix works inside EVAL';
}

{
    sub circumfix:<⌊ ⌋>($e) { $e.floor }
    is ⌊pi⌋, 3, 'circumfix with non-Latin1 bracketing characters';
    is ⌊ pi ⌋, 3, 'circumfix with non-Latin1 bracketing characters, allows spaces';
}

{
    sub postcircumfix:<⌊ ⌋>($int,$arg) { $int + 1 }
    is 1⌊1⌋,2, "sub postcircumfix:<...> works";
    is EVAL(q|1⌊1⌋|),2,"lexically defined postcircumfix works inside EVAL";
}


{
    lives-ok { constant $x = "µ @"; sub circumfix:<<$x>>($) { 42 } },
        'can define circumfix using << >> and both delimiters from the same constant';
    my $test = EVAL 'constant $x = "µ @"; sub circumfix:<<$x>>($) { 42 }; µ 5 @';
    is $test, 42, 'can define and use circumfix using << >> and both delimiters from the same constant (1)';

    lives-ok { constant $x = "µµ @@"; sub circumfix:<<$x>>($) { 42 } },
        'can define circumfix using << >> and both delimiters from the same constant';
       $test = EVAL 'constant $x = "µµ @@"; sub circumfix:<<$x>>($) { 42 }; µµ 5 @@';
    is $test, 42, 'can define and use circumfix using << >> and both delimiters from the same constant (2)';

    lives-ok { constant sym = "µ @"; sub circumfix:<< {sym} >>($) { 42 } },
        'can define circumfix using << {sym} >> and both delimiters from the same constant';
       $test = EVAL 'constant sym = "µ @"; sub circumfix:<< {sym} >>($) { 42 }; µ 5 @';
    is $test, 42, 'can define and use circumfix using << >> and both delimiters from the same constant';

    throws-like { EVAL q[ constant $x = "@ µ ."; sub circumfix:<<$x>>($) { 42 } ] },
        X::Syntax::AddCategorical::TooManyParts, 
        'constants containing too many parts throw correctly';
}
