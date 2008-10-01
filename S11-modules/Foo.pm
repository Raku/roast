module Foo;
sub foo is export(:DEFAULT)         { 'Foo::foo' }  #  :DEFAULT, :ALL
sub bar is export(:DEFAULT :others) { 'Foo::bar' }  #  :DEFAULT, :ALL, :others
sub baz is export(:MANDATORY)       { 'Foo::baz' }  #  (always exported)
sub bop is export                   { 'Foo::bop' }  #  :ALL
sub qux is export(:others)          { 'Foo::qux' }  #  :ALL, :others

