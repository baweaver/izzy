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