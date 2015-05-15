# L<S11/"Exportation"/>

unit module t::spec::packages::S11-modules::Foo;
sub foo is export(:DEFAULT)          { 'Foo::foo' }  #  :DEFAULT, :ALL
sub bar is export(:DEFAULT, :others) { 'Foo::bar' }  #  :DEFAULT, :ALL, :others
sub baz is export(:MANDATORY)        { 'Foo::baz' }  #  (always exported)
sub bop is export                    { 'Foo::bop' }  #  :DEFAULT, :ALL
sub qux is export(:others)           { 'Foo::qux' }  #  :ALL, :others
multi waz() is export                { 'Foo::waz' }  #  :ALL, :DEFAULT (implicit export)
multi gaz() is export(:others)       { 'Foo::gaz1' } #  :ALL, :others
multi gaz($x) is export(:others)     { 'Foo::gaz2' } #  :ALL, :others
