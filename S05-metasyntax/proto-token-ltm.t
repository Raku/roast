use v6;
use Test;

plan 10;

grammar LTM2 {
    proto token TOP {*}
    token TOP:sym<a> { 'aa' }
    token TOP:sym<x> { 'ab' }
    token TOP:sym<y> { 'ac' }
    token TOP:sym<z> { 'a' | 'i' | 'j' }
    token TOP:sym<b> { a**4 }
    token TOP:sym<c> { a**2 % c }
    token TOP:sym<d> { a**3..3 % d }
    token TOP:sym<e> { a**1..* % e }
    token TOP:sym<f> { afafafa? %% f }
    token TOP:sym<g> { agagagaga? % g } # last g is never tried
        token TOP:sym<h> {
            ahahahahaha+ % h }
    token TOP:sym<i> { i**5..6
    }
    token TOP:sym<j> {
        j**7..* }
}

is ~LTM2.parse('aaaaaaaa'), 'aaaa', 'LTM a**4 worked';
is ~LTM2.parse('acacaca'), 'aca', 'LTM a**2 % c worked';
is ~LTM2.parse('adadadadada'), 'adada', 'LTM a**3..3 % d worked';
is ~LTM2.parse('aeaeaea'), 'aeaeaea', 'LTM a**1..* % e worked';
is ~LTM2.parse('afafafafafafa'), 'afafafaf', 'LTM afafafa? %% f worked';
is ~LTM2.parse('agagagagagagaga'), 'agagagaga', 'LTM agaagaga? % g worked';
is ~LTM2.parse('ahahahahahahahaha'), 'ahahahahahahahaha', 'LTM ahaahahaha+ % h worked';
isnt LTM2.parse('ahahahahah'), 'ahahahaha', 'LTM ahahahahaha+ % h~failed correctly';
is ~LTM2.parse('iiiiii'), 'iiiiii', 'LTM i**5..6 worked';
is ~LTM2.parse('jjjjjjjjjj'), 'jjjjjjjjjj', 'LTM j**7..* worked';
