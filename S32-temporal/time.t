use v6;
use Test;

# L<S32::Temporal/C<time>>

# Based Heavily on the t/op/time.t test from Perl5.8.6
# Perhaps the testing of these builtins needs to be more rigorous
# mattc 20050316

plan 10;

#-- subs --

# Sub for evaulation valid date-time strings
# Used in place of Rules for the moment
sub is_dt (Str $datetime) returns Bool {

    my ($dow, $mon, $day, $time, $year) = split(' ', $datetime);
    my $result = 0;

    for < Sun Mon Tue Wed Thu Fri Sat > {
        if $dow eq $_ {
            $result++;
            last();
        }
    }

    for < Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec > {
        if  $mon eq $_ {
            $result++;
            last();
        }
    }

    if $day >= 1 && $day <= 31 {
        $result++;
    }

    my ($hour, $min, $sec) = split(':',$time);

    if $hour >= 0 && $hour <= 23 &&
       $min  >= 0 && $min  <= 59 &&
       $sec  >= 0 && $sec  <= 59 {
        $result++;
    }

    if $year >= 0 && $year <= 9999 {
        $result++;
    }

    return ($result == 5);
}

# Before we get started, sanity check the is_dt sub

#-- 1 --

my $gen_dt      = "Tue Mar 15 14:43:10 2005";
my $hibound_dt     = "Mon Jan 31 23:59:59 9999";
my $lowbound_dt = "Mon Jan 1 00:00:00 0";

ok(is_dt($gen_dt) &&
   is_dt($hibound_dt) &&
   is_dt($lowbound_dt) ,
   'test datetime string tester, pos cases');

#-- 2 --

my $fail_dt_1   = "Mun Mar 15 14:43:10 2005";
my $fail_dt_2   = "Mon Mxr 15 14:43:10 2005";
my $fail_dt_3   = "Mon Mar 32 14:43:10 2005";
my $fail_dt_4   = "Mon Mar 15 24:43:10 2005";
my $fail_dt_5   = "Mon Mar 15 14:60:10 2005";
my $fail_dt_6   = "Mon Mar 15 14:43:60 2005";
my $fail_dt_7   = "Mon Mar 15 14:43:10 10000";

ok(!is_dt($fail_dt_1) &&
   !is_dt($fail_dt_2) &&
   !is_dt($fail_dt_3) &&
   !is_dt($fail_dt_4) &&
   !is_dt($fail_dt_5) &&
   !is_dt($fail_dt_6) &&
   !is_dt($fail_dt_7) ,
   'test datetime string tester, neg cases');

#-- Real Tests Start --

#-- 3 --

my $beg = time;
my $now;

# Loop until $beg in the past
while (($now = time) == $beg) { sleep 1 }

ok($now > $beg && $now - $beg < 10, 'very basic time test');
ok time + 10, "'time()' may drop its parentheses";

#-- 4 --
{
    my ($beguser,$begsys);
    my ($nowuser,$nowsys);

    ($beguser,$begsys) = times;
    my $i;
    loop ($i = 0; $i < 100000; $i++) {
        ($nowuser, $nowsys) = times;
        $i = 200000 if $nowuser > $beguser && ( $nowsys >= $begsys || (!$nowsys && !$begsys));
        $now = time;
        last() if ($now - $beg > 20);
    }
    ok($i >= 200000, 'very basic times test');
}

#-- 5 --
my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);
my ($xsec,$foo);

($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime($beg);
($xsec,$foo) = localtime($now);

my $localyday = $yday;

flunk("FIXME Time::Local should by numifiable");
#ok($sec != $xsec && $mday && $year, 'localtime() list context');

#-- 6 --

ok(is_dt({ my $str = localtime() }()), 'localtime(), scalar context');

# Ultimate implementation as of above test as Rule
#todo_ok(localtime() ~~ /^Sun|Mon|Tue|Wed|Thu|Fri|Sat\s
#                            Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec\s
#                            \d\d\s\d\d:\d\d:\d\d\s\d**{4}$
#                        /,
#                 'localtime(), scalar context');

#-- 7 --

{
    my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst);
    my ($xsec,$foo);

    ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = try { gmtime($beg) };
    ($xsec,$foo) = localtime($now);

    flunk("FIXME Time::Local should by numifiable");
    #ok($sec != $xsec && $mday && $year, 'gmtime() list context');

    #-- 8 --

    if ($localyday && $yday) {
        my $day_diff = $localyday - $yday;
        ok($day_diff == 0    ||
            $day_diff == 1    ||
            $day_diff == -1   ||
            $day_diff == 364  ||
            $day_diff == 365  ||
            $day_diff == -364 ||
            $day_diff == -365,
            'gmtime() and localtime() agree what day of year');
    } else {
        ok(0, 'gmtime() and localtime() agree what day of year');
    }

    #-- 9 --

    ok(is_dt({ my $str = try { gmtime() } }()), 'gmtime(), scalar context');

    # Ultimate implementation as of above test as Rule
    #todo_ok(gmtime() ~~ /^Sun|Mon|Tue|Wed|Thu|Fri|Sat\s
    #                      Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec\s
    #                      \d\d\s\d\d:\d\d:\d\d\s\d**{4}$
    #                    /,
    #            'gmtime(), scalar context');
}

# vim: ft=perl6
