module LoadFromInsideAModule {
    BEGIN { @*INC.push: 't/spec/packages' };
    use Foo;
}
