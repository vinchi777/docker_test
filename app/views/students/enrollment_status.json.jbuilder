json.array! @statuses do |s|
  json.key s[0].titleize
  json.value s[1]
end
