use v6;
use Test;

plan 13;

my @arr := Array.new(:shape(2;2));

is @arr.shape, (2;2), 'shape is set on array';
is @arr.elems, 2, 'elems is size of first dimensions';

ok @arr.eager === @arr, 'eager is identity on a shaped array';
lives-ok { @arr.sink }, 'sink lives on a shaped array';
is @arr.is-lazy, False, 'shaped array knows it is not lazy';

throws-like { @arr.push(1) }, X::IllegalOnFixedDimensionArray, operation => 'push';
throws-like { @arr.append(1) }, X::IllegalOnFixedDimensionArray, operation => 'append';
throws-like { @arr.pop() }, X::IllegalOnFixedDimensionArray, operation => 'pop';
throws-like { @arr.unshift(1) }, X::IllegalOnFixedDimensionArray, operation => 'unshift';
throws-like { @arr.prepend(1) }, X::IllegalOnFixedDimensionArray, operation => 'prepend';
throws-like { @arr.shift() }, X::IllegalOnFixedDimensionArray, operation => 'shift';
throws-like { @arr.splice(1) }, X::IllegalOnFixedDimensionArray, operation => 'splice';
throws-like { @arr.plan(1) }, X::IllegalOnFixedDimensionArray, operation => 'plan';
