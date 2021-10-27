use v6.d;
unit module GH3104_6d;

sub callback-simple(&code) is export {
    code
}

sub callback-in-map(&code) is export {
    <a>.map: { code }
}

sub callback-in-callback(&code) is export {
    callback-simple(&code)
}

sub client-revision is export {
    CLIENT::LEXICAL::<CORE-SETTING-REV>
}

sub client-package is export {
    CLIENT::LEXICAL::<$?PACKAGE>
}

# vim: expandtab shiftwidth=4
