(->

  there_is_an_IE_problem = false

  unless window.console?
    alert 'Please open the developer tools to activate the console.'
    return

  console.log "Stylesheet Audit v3.0"

  stylesheets = document.styleSheets
  console.log "Stylesheets: #{stylesheets.length || 0}"

  for stylesheet in stylesheets

    # Originally added to handle Firefox's
    # "SecurityError: The operation is insecure"
    # when Google Maps includes an external stylesheet
    try
      rules = stylesheet.rules
      num_rules  = if rules? then rules.length else 0
      num_rules_selectors = 0

      cssRules = stylesheet.cssRules
      num_cssRules = if cssRules? then cssRules.length else 0
      num_cssRules_selectors = 0

      source = stylesheet.href || '(Inline)'
    catch err
      console.log err.message
      continue

    if num_rules
      for rule in rules
        if rule.selectorText
          try
            num_rules_selectors += rule.selectorText.split(",").length
          catch err
            console.log err

    if num_cssRules
      for rule in cssRules
        if rule.selectorText
          try
            num_cssRules_selectors += rule.selectorText.split(",").length
          catch err
            console.log err

    console.log "  Stylesheet: #{source}"
    console.log "    (.rules) Rules/Selectors: #{num_rules} / #{num_rules_selectors}" if num_rules
    console.log "    (.cssRules) Rules/Selectors: #{num_cssRules} / #{num_cssRules_selectors}" if num_cssRules

    there_is_an_IE_problem = true if num_cssRules_selectors >= 4095 or num_rules >= 4095

  feedback = if there_is_an_IE_problem then \
    "Met or exceeded IE (&le;9) selector max of 4,095!" else \
    "Selector count is IE-safe."

  alert feedback

  return
)()
