#!/usr/bin/env perl

######################################################################
# fudge-useage-stat.pl
#
# Usage stats of fudge implementations, versions and verbs for roast.
#
######################################################################

use strict;
use warnings;

use File::Find;
use File::Spec::Functions qw(canonpath);
use Text::Table;
use Cwd qw(cwd);

my $find_dir = @ARGV ? canonpath(shift) : '.';

if ( scalar(my @a =  <$find_dir/S0[1-9]*>) < 10 ) {
    die <<"USAGE";
Usage: $0 [roast directory]

   Intended to run against directory with synopses but not many
   synopses in working directory (defaults to cwd).
USAGE
} 

my @fudge_impl;
my %fudge_version;

######################################################################
# Called by File::Find find with a file.  If the file is a test file
# grep it for fudges and extract the parsed fudges.
######################################################################
sub wanted {
    return if (
        $File::Find::dir eq $find_dir and /^fudge(all)?$/           or
        $File::Find::dir =~ m!^$find_dir?/(t|packages)(t/|$)!       or
        -d $File::Find::name                                        or
        # don't want to process fudged files
        # may want to consider less restrictive some day
        not /\.t$/
    );

    open(my $test_fh, $_) or
        die "Could not open file to grep for fudges - $_: $!";
    while (<$test_fh>) {
        next unless /^\s*#\?(?!DOES)/i; # remove 'v' later

        if ( /^\s*#\?(v6\S*)/ ) {
            $fudge_version{ $1 }++;
        }
        elsif ( /^ \s*\#\?
                (                   # 1) implementation
                  ([^.\s]*)         # 2) implementation - compiler
                  (?:\.(\S*))?      # 3) implementation - backend
                )
                \s+
                (?:\d+\s+)?         # optional count
                (\w+)               # 4) verb
        /x ) {
            my $impl_fudge_i = {
                implementation => $1,
                compiler => $2,
                backend => $3,
                verb => $4
            };
            warn "Unknown compiler and implementation: $1"
                if ( $2 !~ /^nie(zc|cz|z)a?|rakudo|mildew|kp6$/ );
            push @fudge_impl, $impl_fudge_i;
        }
        else {
            warn "Unrecognized fudge directive: $_";
        }
    }
}

######################################################################
# Count up fudge implementation usage from the @fudge_impl parsed
# fudge implementation record list.
######################################################################
sub print_count_table {
    my @keys = @_;
    my %count_by_key;

    $count_by_key{ "@{$_}{@keys}" } ++ foreach @fudge_impl;

    my $tb = Text::Table->new(
        @keys, "Count by occurrence"
    );

    $tb->load(map {
            [ (split), $count_by_key{ $_ } ]
        } sort { # sort by (composite) key
            my @a = split ' ', $a; 
            my @b = split ' ', $b; 

            for (my $i = 0; $i < @a; $i++) {
                my $cmp = ($a[ $i ] // '') cmp ($b[ $i ] // '');
                return $cmp if $cmp;
            }
            return 0; 
        } keys %count_by_key );

    print $tb;
}

find (\&wanted, $find_dir);

foreach my $k (qw(implementation compiler verb)) {
    print_count_table $k;
    print $/;
}

my $tb = Text::Table->new( 'version', 'Count by occurrence' );
$tb->load(
    map { [ $_, $fudge_version{ $_ } ] } sort keys %fudge_version
);
print $tb, $/;
