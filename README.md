# Description

This little fellow takes a gander at the current web page's stylesheets and logs their sources, number of rules, and number of selectors to the console. 
An alert will let you know if the number of selectors is OK or meets/exceeds Internet Explorer's limit of 4,095 (for versions &le; 9).

For more information see [stylesheet limitations in Internet Explorer](http://blogs.msdn.com/b/ieinternals/archive/2011/05/14/internet-explorer-stylesheet-rule-selector-import-sheet-limit-maximum.aspx) and [this page](http://demos.telerik.com/testcases/4095issues.html) &mdash; a useful test for maxing out selectors.

# Get It

[Here](http://htmlpreview.github.io?https://raw.github.com/epicyclist/stylesheet-audit-bookmarklet/master/bookmarker/bookmarker.html).

# Changelog

## v3.0

- Only showing a dialog for the problem state wasn't great feedback: now you get a dialog either way.
- Updated the code to handle console errors in IE.
- Added a "Making Changes" section to the README.

## v2.0

The use of `.cssRules` or `.rules` has been changed: now both are examined. This is done to circumvent a problem I discovered in IE9. IE9 supports both `.cssRules` and `.rules`; however, they return different values (in my case, `.rules` returned almost 2,000 more!).

I couldn't find solid information on this. Quirkmode's section on [accessing stylesheets](http://www.quirksmode.org/dom/w3c_css.html#access) mentions a difference in `@import` handling, but this did not apply in my case. This statement was closer to the truth:

> IE... splits up selectors like p#test, ul into two rules. This behaviour persists in IE9, although cssRules works correctly.

When comparing `.cssRules` and `.rules`, I discovered that `.cssRules` reflected the stylesheet, while `.rules` separated the rules into individual selectors. Here's an example:

- `document.styleSheets[0].cssRules[0]` returns "A, B, C"
- `document.styleSheets[0].cssRules[1]` returns "D, E, F"
- `document.styleSheets[0].rules[0]` returns "A, B, C"
- `document.styleSheets[0].rules[1]` returns "B, C"
- `document.styleSheets[0].rules[2]` returns "C"
- `document.styleSheets[0].rules[3]` returns "D, E, F"
- `document.styleSheets[0].rules[4]` returns "E, F"
- `document.styleSheets[0].rules[5]` returns "F"

Because of this, this version logs the results from both and alerts the user if one of the following is true:

1. The number of selectors from `.cssRules` is &ge; 4,095
1. The number of rules from `.rules` is &ge; 4,095

(It's also worth noting that IE9 fails some of the stylesheet tests [here](http://www.quirksmode.org/dom/tests/stylesheets.html).)

# Making Changes

1. Update the README and Changelog
2. Update the coffeescript source (including the version)
3. Convert the coffeescript to javascript (e.g., [http://js2coffee.org](http://js2coffee.org))
4. Minify the javascript (e.g, [http://jscompress.com](http://jscompress.com))
5. Update the bookmarklet (including the version)
6. Tag the repo

# Credits

This is based off [a gist](https://gist.github.com/eltoob/4586719) by eltoob.
