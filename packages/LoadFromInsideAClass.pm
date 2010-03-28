class LoadFromInsideAClass {
    BEGIN { @*INC.push: 't/spec/packages' };
    use Foo;
}
