use v6.c;

class MainLoadsNestedInside::OtherNested {
    use MainLoadsNestedInside::Nested;

    method foo(MainLoadsNestedInside::OtherNested $b) {
    }

    method bar(MainLoadsNestedInside::Nested $b) {
    }
}

class MainLoadsNestedInside {
    use MainLoadsNestedInside::Nested;

    method foo(MainLoadsNestedInside::Nested $b) {
    }

    method bar(MainLoadsNestedInside $b) {
    }
}
