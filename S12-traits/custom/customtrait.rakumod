multi sub trait_mod:<is>(Sub $m, :$customtrait!) is export {
    $m.wrap: sub (|) { nextsame }
}
