(->
  stylesheets = document.styleSheets
  console.log "Stylesheets: #{stylesheets.length || 0}"

  for stylesheet in stylesheets

    # Originally added to handle Firefox's
    # "SecurityError: The operation is insecure"
    # when Google Maps includes an external stylesheet
    try
      rules = stylesheet.cssRules || stylesheet.rules
      num_rules  = if rules? then rules.length else 0
      num_selectors = 0
      source = stylesheet.href || '(Inline)'
    catch err
      console.log err.message
      continue

    if num_rules
      for rule in rules
        if rule.selectorText
          try
            num_selectors += rule.selectorText.split(",").length
          catch err
            console.log err

    console.log "  Stylesheet: #{source}\n"
    console.log "    Rules/Selectors: #{num_rules} / #{num_selectors}\n"

    alert "Met or exceeded IE (&le;9) selector max of 4,095!" if num_selectors >= 4095

  return
)();
