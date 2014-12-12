json.array! @invoices do |i|
  json.id i.id.to_s
  json.package i.package
  json.description i.description
  json.amount i.amount
  json.discount i.discount
  json.student_id i.student_enrollment.student_id.to_s
  json.transactions i.transactions do |t|
    json.id t.id.to_s
    json.date t.date
    json.or_no t.or_no
    json.method t.method
    json.amount t.amount
  end
  json.review_season do
    json.id i.review_season.id.to_s
    json.season i.review_season.season
  end
  json.url student_invoice_url(i, format: :json)
end
