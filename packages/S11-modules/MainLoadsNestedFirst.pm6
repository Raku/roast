use v6.c;

use MainLoadsNestedFirst::Nested;

class MainLoadsNestedFirst::OtherNested {
    method foo(MainLoadsNestedFirst::Nested $b) {
    }

    method bar(MainLoadsNestedFirst::OtherNested $b) {
    }
}

class MainLoadsNestedFirst {
    method foo(MainLoadsNestedFirst::Nested $b) {
    }

    method bar(MainLoadsNestedFirst $b) {
    }
}
