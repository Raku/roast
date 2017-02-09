use v6;
use Test;

plan 55 * 2 + 1;

constant $fancy-nums       = '໕໖໗۶۷៤៥１２３';
constant $fancy-nums-value = 5676745123;

constant $all-chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklm'
    ~ 'nopqrstuvwxyz.0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghi'
    ~ 'jklmnopqrstuvwxyz';

constant $all-chars-result = 2527079815159757168093382078421796304289747094823514859938627964591248797616216274592478001915.000816326530612244738449589931406080722808837890625;

for &parse-base, Str.^lookup('parse-base') -> &pb {
    my $t = " ({&pb.^name.lc} form)";

    is-deeply pb('Perl6',  30), 20652936,    '"Perl6"  in base-30' ~ $t;
    is-approx pb('Perl.6', 32), 834421.1875, '"Perl.6" in base-32' ~ $t;

    is-deeply pb('1111', $_), +":{$_}<1111>", "1111 in base-$_" ~ $t
        for 2..36;
    is-approx pb($all-chars, 36), $all-chars-result,
        'full character set' ~ $t;

    is-deeply pb(       '-FF', 16), -255, 'can parse - sign' ~ $t;
    is-deeply pb("\x[2212]FF", 16), -255,
        'can parse − sign (fancy Unicode minus)' ~ $t;
    is-deeply pb(       '+FF', 16),  255, 'can parse + sign';

    is-deeply pb( '.42', 10),  .42, 'fractional without whole part';
    is-deeply pb('+.42', 10),  .42, 'fractional without whole part with +';
    is-deeply pb('-.42', 10), -.42, 'fractional without whole part with -';
    is-deeply pb('−.42', 10), -.42, 'fractional without whole part with U+2212';

    #?rakudo.jvm todo 'Invalid base-10 character'
    is-deeply pb($fancy-nums, 10), $fancy-nums-value,
        'can parse fancy Unicode numerals as Int' ~ $t;

    #?rakudo.jvm skip 'Cannot resolve caller is-approx(Failure, Rat, Str)'
    is-approx pb("$fancy-nums.$fancy-nums", 10),
        "$fancy-nums-value.$fancy-nums-value".Numeric,
        'can parse fancy Unicode numerals as float' ~ $t;

    throws-like { pb "Perl6", 42 },
        X::Syntax::Number::RadixOutOfRange, radix => 42,
    'too large radix throws' ~ $t;

    throws-like { pb "Perl6", -1 },
        X::Syntax::Number::RadixOutOfRange, radix => -1,
    'too small radix throws' ~ $t;

    throws-like { pb "###", 20     }, X::Str::Numeric,
        reason => /'base-20'/, :0pos, :source<###>,
    'invalid char at first position, base 20' ~ $t;

    throws-like { pb "-1238321", 8 }, X::Str::Numeric,
        reason => /'base-8'/, :4pos, :source<-1238321>,
    'invalid char in middle position, base 8' ~ $t;

    throws-like { pb "124", 4      }, X::Str::Numeric,
        reason => /'base-4'/, :2pos, :source<124>,
    'invalid char at last position, base 4' ~ $t;

    throws-like { pb "−1.5x", 8    }, X::Str::Numeric,
        reason => /'base-8'/, :4pos, :source<−1.5x>,
    'invalid char in last position, negative, base 8' ~ $t;

    throws-like { pb "−1.5x", 8    }, X::Str::Numeric,
        reason => /'base-8'/, :4pos, :source<−1.5x>,
    'invalid char in last position, negative, base 8' ~ $t;

    throws-like { pb "1.x", 9      }, X::Str::Numeric,
        reason => /'base-9'/, :2pos, :source<1.x>,
    'invalid char in first position of fractional part, base 9' ~ $t;
}
is-deeply '1111'.parse-base(1), 4, "parse-base 1111 in base-1 is 4";

# vim: ft=perl6
