(function() {

  var
    styleSheets = document.styleSheets,
    totalStyleSheets = styleSheets.length;

  for (var j = 0; j < totalStyleSheets; j++) {

    var
      styleSheet = styleSheets[j],
      rules = styleSheet.cssRules || styleSheet.rules,
      totalRulesInStylesheet = rules.length,
      totalSelectorsInStylesheet = 0;

    for (var i = 0; i < totalRulesInStylesheet; i++) {
      if (rules[i].selectorText) {
        try {
          totalSelectorsInStylesheet += rules[i].selectorText.split(',').length;
        }
        catch(err) {
          console.log(err);
        }
      }
    }

    console.log(
      "Stylesheet: " + styleSheet.href + "\n" +
      "Rules: " + totalRulesInStylesheet + "\n" +
      "Selectors: " + totalSelectorsInStylesheet + "\n"
    )

    if (totalSelectorsInStylesheet >= 4095) {
      alert("Met or exceeded IE selector max of 4,095!")
    }

  }
})();
