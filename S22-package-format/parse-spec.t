use v6;
use Test;

plan 10;

for (

  ( '/foo/bar' =>
    [ $( CompUnitRepo::Local::File, ().hash, '/foo.bar' ) ] ),
  ( 'file:/foo/bar' =>
    [ $( CompUnitRepo::Local::File, ().hash, '/foo.bar' ) ] ),
  ( 'inst:/installed' =>
    [ $( CompUnitRepo::Local::Installation, ().hash, '/installed' ) ] ),
  ( 'CompUnitRepo::Local::Installation:/installed' =>
    [ $( CompUnitRepo::Local::Installation, ().hash, '/installed' ) ] ),
  ( 'inst:name<work>:/installed' =>
    [ $( CompUnitRepo::Local::Installation, { :name<work> }, '/installed' ) ] ),
  ( 'inst:name[work]:/installed' =>
    [ $( CompUnitRepo::Local::Installation, { :name<work> }, '/installed' ) ] ),
  ( 'inst:name{work}:/installed' =>
    [ $( CompUnitRepo::Local::Installation, { :name<work> }, '/installed' ) ] ),
  ( '/foo/bar  ,  /foo/baz' =>
    [ $( CompUnitRepo::Local::File, ().hash, '/foo.bar' ),
      $( CompUnitRepo::Local::File, ().hash, '/foo.baz' ) ] ),
  ( 'inst:/installed, /also' =>
    [ $( CompUnitRepo::Local::Installation, ().hash, '/installed' ),
      $( CompUnitRepo::Local::Installation, ().hash, '/installed' ) ] ),
  ( '/foo/bar , inst:/installed' =>
    [ $( CompUnitRepo::Local::File, ().hash, '/foo.bar' ),
      $( CompUnitRepo::Local::Installation, ().hash, '/installed' ) ] ),

) -> $to-check {
    my $checking := $to-check.key;
    my @answers  := $to-check.value;

    my $result = CompUnitRepo.parse-spec($checking);
    subtest {
        ok $result ~~ Positional, "'$checking' got a Positional";
#        ok $result[0] === @answers[0], "'$checking' got us the right type";
    }, "'$checking' parses ok";
}

#  'CompUnitRepo::GitHub:masak/html-template'
