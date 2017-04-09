use v6;
use Test;
# L<S32::IO/IO::Spec>

plan 28;

my $SPEC := IO::Spec::QNX;
my %canonpath = (
    'a/b/c'              => 'a/b/c',
    '//a//b//'           => '//a/b',
	'a/../../b/c'        => 'a/../../b/c',
	'/.'                 => '/',
	'/./'                => '/',
	'/a/./'              => '/a',
	'/a/.'               => '/a',
	'/../../'            => '/',
	'/../..'             => '/',
	'/..'                => '/',
        'a\\\\b'             => 'a\\\\b',
	''                   => '',
        '0'                  => '0',
	'///../../..//./././a//b/.././c/././' => '/a/b/../c',
);
for %canonpath.kv -> $get, $want {
	is $SPEC.canonpath( $get ), $want, "canonpath: '$get' -> '$want'";
}
my %canonpath-parent = (
	"foo/bar/.."         => "foo",
	"foo/bar/baz/../.."  => "foo",
	"/foo/.."            => "/",
	"foo/.."             => '.',
	"foo/../bar/../baz"  => "baz",
	"foo/../../bar"      => "../bar",
	"../../.."           => "../../..",
	"/../../.."          => "/",
	"/foo/../.."         => "/",
	"0"                  => "0",
        ''                   => '',
	"//../..usr/bin/../foo/.///ef"   => "//../..usr/foo/ef",
	'///../../..//./././a//b/.././c/././' => '/a/c',
);
for %canonpath-parent.kv -> $get, $want {
	is $SPEC.canonpath( $get , :parent ), $want, "canonpath(:parent): '$get' -> '$want'";
}
quietly is $SPEC.canonpath( Any , :parent ), '',
    "canonpath(:parent): Any -> ''";
