###
 AutoCompute Plugin v1.0

 Copyright 2014, James Euangel E. Limpiado
###

# Mirror fetched json values when clicking select option
window.selects_fetch = (element) ->
  unless element.hasClass 'select_fetched'
    element.addClass 'select_fetched'
    scope = element.closest '.sf-scope'
    selects = element.data('sf-selects').split ' '

    for s in selects
      _var = s.substring(1, s.length)
      _scope = get_scope scope, s
      filtered_var = _var.replace(/\$|@/g, '')

      _scope.on 'change', filtered_var, ->
        update_select_fetch element, selects, scope

    update_select_fetch element, selects, scope

window.refresh_select_fetch = (element) ->
  scope = element.closest '.sf-scope'
  selects = element.data('sf-selects').split ' '
  update_select_fetch element, selects, scope

update_select_fetch = (element, selects, scope) ->
  values = {}
  url = element.data 'sf-url'

  for s in selects
    e = get_variable scope, s
    values[e.data('sf-key')] = get_element_val(e)

  $.get url, values, (data) ->
    set_element_val(element, data)

  # use asynchronous for the meantime
  ###$.ajax(
    url: url,
    data: values,
    success: (data) ->
      set_element_val(element, data)
    , async: false
  )###



# Adds autocompute listener and auto updates element value
window.auto_compute = (element) ->
  unless element.hasClass 'auto_computed'
    element.addClass 'auto_computed'
    formula = element.data('ac-expr')
    scope = element.closest('.ac-scope')
    variables = extract_variables formula, scope

    for k,v of variables
      _var = k.substring(1, k.length)
      _scope = get_scope scope, k
      filtered_var = _var.replace(/\$|@/g, '')
      _scope.on 'keyup change', filtered_var, ->
        variables = update_variables variables, scope
        reflect_answer formula, variables, element

    reflect_answer formula, variables, element

window.refresh_auto_compute = (element) ->
  formula = element.data('ac-expr')
  scope = element.closest('.ac-scope')
  variables = extract_variables formula, scope
  reflect_answer formula, variables, element

# Reflect answer on target element
reflect_answer = (formula, variables, element) ->
  answer = compute_formula formula, variables
  if element.is(':input')
    set_element_val element, answer
    mirror = element.siblings('.ac-mirror').first()
    if mirror
      reflect_answer_with_addons answer, mirror
  else
    reflect_answer_with_addons answer, element


# Add prefix or suffix to answer if any
reflect_answer_with_addons = (answer, element) ->
  prefix = element.data('ac-prefix') || ''
  suffix = element.data('ac-suffix') || ''
  set_element_val element, "#{prefix} #{answer.toLocaleString()} #{suffix}"


# Extract variables from a given string and queries values for each variable
extract_variables = (formula, scope) ->
  variables = {}
  for e in formula.split(' ')
    if e.indexOf('$') == 0 || e.indexOf('@') == 0
      variables[e] = get_variable_value scope, e
    else if e.indexOf('loop') == 0
      data = e.substring(5, e.length - 1)
      params = data.split(',')
      variable = params[0].trim()
      operator = params[1].trim()
      variables[variable] = [get_loop_value(scope, variable, operator), e]

  return variables


# Update variable values
update_variables = (variables, scope) ->
  for k,v of variables
    if v[1]
      data = v[1].substring(5, v[1].length - 1)
      params = data.split(',')
      variable = params[0].trim()
      operator = params[1].trim()
      variables[k] = [get_loop_value(scope, variable, operator), v[1]]
    else
      variables[k] = get_variable_value scope, k

  return variables

get_scope = (scope, variable) ->
  _var = variable.substring(1, variable.length)
  if variable.indexOf('$') == 0
    if _var.indexOf('$') == 0
      ac_scope = scope.hasClass 'ac-scope'
      parent = scope.parent()
      next_scope = if ac_scope then parent.closest('.ac-scope') else parent.closest('.sf-scope')
      return get_scope next_scope, _var
    else
      scope
  else if variable.indexOf('@') == 0
    $(document)

# Check if variable is local '$' or global '@' and get corresponding value
get_variable = (scope, variable) ->
  _scope = get_scope scope, variable
  filtered_var = variable.replace(/\$|@/g, '')
  _scope.find(filtered_var).first()


get_variable_value = (scope, variable) ->
  get_element_val_num get_variable(scope, variable)


get_loop_value = (scope, variable, operator) ->
  _var = variable.substring(1, variable.length)
  results = if variable.indexOf('$') == 0 then scope.find(_var) else $(_var)
  return 0 if results.length == 0

  formula = ''

  for v in results
    formula += get_element_val_num $(v)
    formula += operator

  math.eval formula.substr(0, formula.length - 1)


# Computes formula with a set of variables
compute_formula = (formula, variables) ->
  for k,v of variables
    if v[1]
      formula = formula.replace(v[1], v[0])
    else
      formula = formula.replace(k, v)

  math.eval formula


# Gets element value or text
get_element_val = (e) ->
  val = if e.is(':input') then e.val() else e.text()
  val.trim()


# Sets element value or text
set_element_val = (e, val) ->
  if e.is(':input') then e.val(val) else e.text(val)
  e.change()


# Gets element value or text and convert to number
get_element_val_num = (e) ->
  to_num get_element_val e


# Converts string to number
to_num = (string) ->
  num = parseFloat(string.replace(/,/g, ''))
  if isNaN(num) then 0 else num

$(document).on 'change', '.select-fetch', ->
  select_fetch $(this)

$(document).on 'change', '.select-combi-fetch', ->
  select_combi_fetch $(this)

# check for potential targets every node inserted
$(document).on 'DOMNodeInserted', 'body', (e) ->
  target = $(e.target)
  selects_fetch($(e))for e in target.find('.sf-target').not('.select_fetched')
  auto_compute($(e)) for e in target.find('.ac-target').not('.auto_computed')

$ ->
  auto_compute($(e)) for e in $('.ac-target')
  selects_fetch($(e)) for e in $('.sf-target')



