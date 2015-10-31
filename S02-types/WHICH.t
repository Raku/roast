use v6;
use Test;

my @normal = (
  'AST',
  'Any',
  'array',
  'Array',
  'Attribute',
  'Backtrace',
  'Backtrace::Frame',
  'Bag',
  'BagHash',
  'Blob',
  'Block',
  'Bool',
  'Buf',
  'CallFrame',
  'Capture',
  'Code',
  'CompUnit',
  'CompUnitRepo',
  'CompUnitRepo::Distribution',
  'CompUnitRepo::Local::File',
  'CompUnitRepo::Local::Installation',
  'Compiler',
  'Complex',
  'ComplexStr',
  'Cool',
  'Cursor',
  'Date',
  'DateTime',
  'Deprecation',
  'Distribution',
  'Distro',
  'Duration',
  'Map',
  'Exception',
  'Failure',
  'FatRat',
  'ForeignCode',
  'Grammar',
  'Hash',
  'HyperConfiguration',
  'HyperSeq',
  'HyperWhatever',
  'HyperWorkBuffer',
  'IO::ArgFiles',
  'IO::Dir',
  'IO::File',
  'IO::Handle',
  'IO::Notification',
  'IO::Path',
  'IO::Path::Cygwin',
  'IO::Path::QNX',
  'IO::Path::Unix',
  'IO::Path::Win32',
  'IO::Pipe',
  'IO::Socket::INET',
  'IO::Spec',
  'IO::Spec::Cygwin',
  'IO::Spec::QNX',
  'IO::Spec::Unix',
  'IO::Spec::Win32',
  'Instant',
  'Int',
  'IntAttrRef',
  'IntLexRef',
  'IntPosRef',
  'IntStr',
  'IterationBuffer',
  'JSONPrettyActions',
  'Junction',
  'Kernel',
  'Label',
  'List',
  'Lock',
  'Macro',
  'Map',
  'Match',
  'Metamodel::Primitives',
  'Method',
  'Mix',
  'MixHash',
  'Mu',
  #?rakudo.jvm emit # NYI - RT #124500
  'NFC',
  #?rakudo.jvm emit # NYI - RT #124500
  'NFD',
  #?rakudo.jvm emit # NYI - RT #124500
  'NFKC',
  #?rakudo.jvm emit # NYI - RT #124500
  'NFKD',
  'Num',
  'NumAttrRef',
  'NumLexRef',
  'NumPosRef',
  'NumStr',
  'ObjAt',
  'Pair',
  'Parameter',
  'Perl',
  'Perl5ModuleLoaderStub',
  'Pod::Block',
  'Pod::Block::Code',
  'Pod::Block::Comment',
  'Pod::Block::Declarator',
  'Pod::Block::Named',
  'Pod::Block::Para',
  'Pod::Block::Table',
  'Pod::Config',
  'Pod::FormattingCode',
  'Pod::Heading',
  'Pod::Item',
  'Pod::Raw',
  'PseudoStash',
  'Rakudo::Internals',
  'Range',
  'Rat',
  'RatStr',
  'Regex',
  'Routine',
  'Scalar',
  'Seq',
  'Set',
  'SetHash',
  'Signature',
  'Slang',
  'Slip',
  'SprintfHandler',
  'Stash',
  'Str',
  'StrAttrRef',
  'StrDistance',
  'StrLexRef',
  'StrPosRef',
  'Sub',
  'Submethod',
  'UInt',
  #?rakudo.jvm emit # NYI - RT #124500
  'Uni',
  'VM',
  'Variable',
  'Version',
  'Whatever',
  'WhateverCode',
  'bit',
  'byte',
  'int',
  'int1',
  'int16',
  'int32',
  'int2',
  'int4',
  'int64',
  'int8',
  'num',
  'num32',
  'num64',
  'str',
  'uint',
  'uint1',
  'uint16',
  'uint2',
  'uint32',
  'uint4',
  'uint64',
  'uint8',
  'utf16',
  'utf32',
  'utf8',
);

my @exception = <
  X::AdHoc
  X::Adverb
  X::Anon::Augment
  X::Anon::Multi
  X::Assignment::RO
  X::Assignment::RO::Comp
  X::Attribute::NoPackage
  X::Attribute::Package
  X::Attribute::Regex
  X::Attribute::Required
  X::Attribute::Undeclared
  X::Augment::NoSuchType
  X::Backslash::NonVariableDollar
  X::Backslash::UnrecognizedSequence
  X::Bind
  X::Bind::NativeType
  X::Bind::Slice
  X::Bind::ZenSlice
  X::Buf::AsStr
  X::Buf::Pack
  X::Buf::Pack::NonASCII
  X::Caller::NotDynamic
  X::Cannot::Empty
  X::Cannot::Lazy
  X::Comp::AdHoc
  X::Comp::BeginTime
  X::Comp::Group
  X::Comp::NYI
  X::Comp::Trait::NotOnNative
  X::Comp::Trait::Scope
  X::Comp::Trait::Unknown
  X::Composition::NotComposable
  X::Constructor::Positional
  X::ControlFlow
  X::ControlFlow::Return
  X::DateTime::InvalidDeltaUnit
  X::DateTime::TimezoneClash
  X::Declaration::OurScopeInRole
  X::Declaration::Scope
  X::Declaration::Scope::Multi
  X::Does::TypeObject
  X::Dynamic::NotFound
  X::Dynamic::Postdeclaration
  X::Eval::NoSuchLang
  X::Export::NameClash
  X::EXPORTHOW::Conflict
  X::EXPORTHOW::InvalidDirective
  X::EXPORTHOW::NothingToSupersede
  X::Hash::Store::OddNumber
  X::HyperOp::Infinite
  X::HyperOp::NonDWIM
  X::HyperWhatever::Multiple
  X::IllegalOnFixedDimensionArray
  X::IO::Chdir
  X::IO::Chmod
  X::IO::Copy
  X::IO::Cwd
  X::IO::Dir
  X::IO::Directory
  X::IO::DoesNotExist
  X::IO::Link
  X::IO::Mkdir
  X::IO::NotAFile
  X::IO::Rename
  X::IO::Rmdir
  X::IO::Symlink
  X::IO::Unlink
  X::Immutable
  X::Import::MissingSymbols
  X::Import::NoSuchTag
  X::Import::OnlystarProto
  X::Import::Positional
  X::Import::Redeclaration
  X::Inheritance::NotComposed
  X::Inheritance::SelfInherit
  X::Inheritance::UnknownParent
  X::Inheritance::Unsupported
  X::InvalidType
  X::InvalidTypeSmiley
  X::Item
  X::Localizer::NoContainer
  X::Match::Bool
  X::Method::InvalidQualifier
  X::Method::NotFound
  X::Method::Private::Permission
  X::Method::Private::Unqualified
  X::Mixin::NotComposable
  X::Multi::Ambiguous
  X::Multi::NoMatch
  X::NYI
  X::NYI::Available
  X::NoDispatcher
  X::NoSuchSymbol
  X::NotEnoughDimensions
  X::NotParametric
  X::Numeric::DivideByZero
  X::Numeric::Real
  X::Obsolete
  X::OutOfRange
  X::Package::Stubbed
  X::Pairup::OddNumber
  X::Parameter::AfterDefault
  X::Parameter::BadType
  X::Parameter::Default
  X::Parameter::Default::TypeCheck
  X::Parameter::InvalidType
  X::Parameter::MultipleTypeConstraints
  X::Parameter::Placeholder
  X::Parameter::RW
  X::Parameter::Twigil
  X::Parameter::WrongOrder
  X::Phaser::Multiple
  X::Phaser::PrePost
  X::PhaserExceptions
  X::Placeholder::Attribute
  X::Placeholder::Block
  X::Placeholder::Mainline
  X::Placeholder::NonPlaceholder
  X::PoisonedAlias
  X::Pragma::CannotWhat
  X::Pragma::MustOneOf
  X::Pragma::NoArgs
  X::Pragma::OnlyOne
  X::Pragma::UnknownArg
  X::PseudoPackage::InDeclaration
  X::Range::InvalidArg
  X::Redeclaration
  X::Redeclaration::Outer
  X::Role::Initialization
  X::Role::Parametric::NoSuchCandidate
  X::Routine::Unwrap
  X::Seq::Consumed
  X::Seq::NotIndexable
  X::Sequence::Deduction
  X::Set::Coerce
  X::Signature::NameClash
  X::Signature::Placeholder
  X::Str::Match::x
  X::Str::Numeric
  X::Str::Trans::IllegalKey
  X::Str::Trans::InvalidArg
  X::StubCode
  X::Subscript::Negative
  X::Syntax::AddCategorical::TooFewParts
  X::Syntax::AddCategorical::TooManyParts
  X::Syntax::Adverb
  X::Syntax::Argument::MOPMacro
  X::Syntax::Augment::Illegal
  X::Syntax::Augment::WithoutMonkeyTyping
  X::Syntax::BlockGobbled
  X::Syntax::CannotMeta
  X::Syntax::Comment::Embedded
  X::Syntax::ConditionalOperator::PrecedenceTooLoose
  X::Syntax::ConditionalOperator::SecondPartGobbled
  X::Syntax::ConditionalOperator::SecondPartInvalid
  X::Syntax::Confused
  X::Syntax::DuplicatedPrefix
  X::Syntax::Extension::Category
  X::Syntax::Extension::Null
  X::Syntax::Extension::SpecialForm
  X::Syntax::Extension::TooComplex
  X::Syntax::InfixInTermPosition
  X::Syntax::KeywordAsFunction
  X::Syntax::Malformed
  X::Syntax::Malformed::Elsif
  X::Syntax::Missing
  X::Syntax::Name::Null
  X::Syntax::NegatedPair
  X::Syntax::NoSelf
  X::Syntax::NonAssociative
  X::Syntax::Number::IllegalDecimal
  X::Syntax::Number::RadixOutOfRange
  X::Syntax::P5
  X::Syntax::Perl5Var
  X::Syntax::Pod::BeginWithoutEnd
  X::Syntax::Pod::BeginWithoutIdentifier
  X::Syntax::Regex::Adverb
  X::Syntax::Regex::MalformedRange
  X::Syntax::Regex::NullRegex
  X::Syntax::Regex::SolitaryBacktrackControl
  X::Syntax::Regex::SolitaryQuantifier
  X::Syntax::Regex::SpacesInBareRange
  X::Syntax::Regex::UnrecognizedMetachar
  X::Syntax::Regex::UnrecognizedModifier
  X::Syntax::Regex::Unspace
  X::Syntax::Regex::Unterminated
  X::Syntax::Reserved
  X::Syntax::Self::WithoutObject
  X::Syntax::Signature::InvocantMarker
  X::Syntax::Term::MissingInitializer
  X::Syntax::UnlessElse
  X::Syntax::Variable::BadType
  X::Syntax::Variable::ConflictingTypes
  X::Syntax::Variable::IndirectDeclaration
  X::Syntax::Variable::Initializer
  X::Syntax::Variable::Match
  X::Syntax::Variable::MissingInitializer
  X::Syntax::Variable::Numeric
  X::Syntax::Variable::Twigil
  X::Syntax::VirtualCall
  X::Temporal::InvalidFormat
  X::TooLateForREPR
  X::Trait::NotOnNative
  X::Trait::Scope
  X::Trait::Unknown
  X::TypeCheck
  X::TypeCheck::Argument
  X::TypeCheck::Assignment
  X::TypeCheck::Binding
  X::TypeCheck::Return
  X::TypeCheck::Splice
  X::Undeclared
  X::Undeclared::Symbols
  X::UnitScope::Invalid
  X::UnitScope::TooLate
  X::Value::Dynamic
  X::Worry
  X::Worry::P5
  X::Worry::P5::BackReference
  X::Worry::P5::LeadingZero
  X::Worry::P5::Reference
>;

my @concurrent = <
  Cancellation
  Channel
  CurrentThreadScheduler
  IO::Notification
  IO::Socket::Async
  Promise
  Semaphore
  SupplyOperations
  Tap
  Thread
  ThreadPoolScheduler
  X::Channel::ReceiveOnClosed
  X::Channel::SendOnClosed
  X::Lock::ConditionVariable::New
  X::Promise::CauseOnlyValidOnBroken
  X::Promise::Combinator
  X::Promise::Vowed
  X::Supply::Migrate::Needs
  X::Supply::On::BadSetup
  X::Supply::On::NoEmit
>;

my @moar = <
  Proc::Async
  X::Proc::Async::AlreadyStarted
  X::Proc::Async::CharsOrBytes
  X::Proc::Async::MustBeStarted
  X::Proc::Async::OpenForWriting
  X::Proc::Async::TapBeforeSpawn
>;

plan 4 + 4 * ( @normal + @exception + @concurrent + @moar );

is Nil.WHICH,             'Nil', "checking Nil.WHICH";
is Nil.WHICH.WHAT.perl, 'ObjAt', "Nil returns an ObjAt";
is Nil.perl,              'Nil', "Nil.perl returns 'Nil'";
is Nil.gist,              'Nil', "Nil.gist returns 'Nil'";

for @normal -> $class {
    is ::($class).WHICH,            $class, "checking $class.WHICH";
    is ::($class).WHICH.WHAT.perl, 'ObjAt', "$class returns an ObjAt";
    is ::($class).perl,             $class, "$class.perl returns self";
    is ::($class).gist,         "($class)", "$class.gist returns self";
}

for @exception -> $class {
    is ::($class).WHICH,            $class, "checking $class.WHICH";
    is ::($class).WHICH.WHAT.perl, 'ObjAt', "$class returns an ObjAt";
    is ::($class).perl,             $class, "$class.perl returns self";
    is ::($class).gist,         "($class)", "$class.gist returns self";
}

for @concurrent -> $class {
    is ::($class).WHICH,            $class, "checking $class.WHICH";
    is ::($class).WHICH.WHAT.perl, 'ObjAt', "$class returns an ObjAt";
    is ::($class).perl,             $class, "$class.perl returns self";
    is ::($class).gist,         "($class)", "$class.gist returns self";
}

for @moar -> $class {
    #?rakudo.jvm 4    skip 'NYI on jvm - RT #126524'
    is ::($class).WHICH,            $class, "checking $class.WHICH";
    is ::($class).WHICH.WHAT.perl, 'ObjAt', "$class returns an ObjAt";
    is ::($class).perl,             $class, "$class.perl returns self";
    is ::($class).gist,         "($class)", "$class.gist returns self";
}
