use Test;

plan 14;

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
    lives-ok { my constant $x = "µ @"; sub circumfix:<<$x>>($) { 42 } },
        'can define circumfix using << >> and both delimiters from the same constant';
    my $test = EVAL 'my constant $x = "µ @"; sub circumfix:<<$x>>($) { 42 }; µ 5 @';
    is $test, 42, 'can define and use circumfix using << >> and both delimiters from the same constant (1)';

    lives-ok { my constant $x = "µµ @@"; sub circumfix:<<$x>>($) { 42 } },
        'can define circumfix using << >> and both delimiters from the same constant';
       $test = EVAL 'my constant $x = "µµ @@"; sub circumfix:<<$x>>($) { 42 }; µµ 5 @@';
    is $test, 42, 'can define and use circumfix using << >> and both delimiters from the same constant (2)';

    lives-ok { my constant sym = "µ @"; sub circumfix:<< {sym} >>($) { 42 } },
        'can define circumfix using << {sym} >> and both delimiters from the same constant';
       $test = EVAL 'my constant sym = "µ @"; sub circumfix:<< {sym} >>($) { 42 }; µ 5 @';
    is $test, 42, 'can define and use circumfix using << >> and both delimiters from the same constant';

    throws-like { EVAL q[ my constant $x = "@ µ ."; sub circumfix:<<$x>>($) { 42 } ] },
        X::Syntax::AddCategorical::TooManyParts,
        'constants containing too many parts throw correctly';
}

# vim: expandtab shiftwidth=4
