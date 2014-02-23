# Changelog

## v 0.0.1 - Initial Release

Methods added:
* is_all_of?
* is_any_of?
* is_none_of?

## v 1.0.0 - Refinements to methods

Methods changed:
* is_x_of? to x_of?

## v 2.0.0 - Monkey Patch to Module

Updated Izzy to use module instead of explicit patch to object.

### v 2.1.0 - Matcher Methods

Added matchers which support === evaluation

Methods added:
* matches_all?
* matches_any?
* matches_none?
* [private] method_check
* [private] matcher_check

## v 3.0.0 - Multi Matchers

Removed implied ? from boolean matchers, prompting version up. Added multi matching capability to matchers, allowing for multiple conditionals to be passed as an array.

Methods changed:
* matches_all?
* matches_any?
* matches_none?
* [private] matcher_check

## v 3.1.0 - Multi Object Matchers via Array

Added a module to be mixed into Array, allowing for encapsulation of function evaluation on all objects in an Array.

Methods added:
* all_are
* any_are
* none_are

## v 3.2.0 - Merge QEnumerable

Merged the QEnumerable gem into Izzy because of similarities. Removed respond_to? on checks (not including arrays) in order to skim down the time.

Methods added:
* select_where
* reject_where
* find_where