use v6;
use Test;
plan 1;

grammar DateSpec::Grammar {
    rule TOP {
        [<count><.quant>?]?
        <day-of-week>
        [<sign>? <offset=count>]?
    }
    token count { \d+ }
    token quant { st | nd | rd | th }
    token day-of-week { :i
        [ mon | tue | wed | thu | fri | sat | sun ]
    }
    token sign { '+' | '-' }
}

my %dow = (mon => 1, tue => 2, wed => 3, thu => 4,
        fri => 5, sat => 6, sun => 7);

class DateSpec {
    has $.day-of-week;
    has $.count;
    has $.offset;

    multi method new(Str $s) {
        my $m = DateSpec::Grammar.parse($s);
        die "Invalid date specification '$s'\n" unless $m;
        self.bless(
            :day-of-week(%dow{lc $m<day-of-week>}),
            :count($m<count> ?? +$m<count>[0] !! 1),
            :offset( ($m<sign> eq '-' ?? -1 !! 1)
                    * ($m<offset> ?? +$m<offset> !! 0)),
        );
    }

    method based-on(Date $d is copy where { .day == 1}) {
        ++$d until $d.day-of-week == $.day-of-week;
        $d += 7 * ($.count - 1) + $.offset;
        return $d;
    }
    method next(Date $d = Date.today) {
        my $month-start = $d.truncated-to('month');
        my $candidate   = $.based-on($month-start);
        if $candidate ge $d {
            return $candidate;
        }
        else {
            return $.based-on($month-start + $month-start.days-in-month);
        }
    }
}

my $spec = DateSpec.new('3rd Tue + 2');

is $spec.next(Date.new(2013, 12, 25)), '2014-01-23', 'Recurring date spec';
