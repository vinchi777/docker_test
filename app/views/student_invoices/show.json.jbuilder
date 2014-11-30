json.id @invoice.id.to_s
json.package @invoice.package
json.description @invoice.description
json.amount @invoice.amount
json.discount @invoice.discount
json.student_id @invoice.student_id
json.transactions @invoice.transactions do |t|
  json.id t.id
  json.date t.date
  json.or_no t.or_no
  json.method t.method
  json.amount t.amount
end
json.url student_invoice_url(@invoice, format: :json)
