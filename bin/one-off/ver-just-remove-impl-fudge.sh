#!/bin/sh

######################################################################
# grep against git diff to make sure only difference is
# removal of implementation fudges.
#
# output should be empty
#
# takes commit identifiers (e.g HEAD^) as optional arguments
######################################################################

git diff "$@" -U0 |
    egrep -v `# remove git lines that are not file diff` \
        '^(\+\+\+|\-\-\-|diff \-\-git |index [0-9a-f]+\.|@@[-0-9+, ]+@@)' |
    egrep -v '^-\s*#\?(niecza|mildew|kp6)\s'
