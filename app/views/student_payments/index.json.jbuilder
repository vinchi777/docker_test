json.array!(@student_payments) do |student_payment|
  json.extract! student_payment, :id, :description, :reviewSeasons, :amount, :discount
  json.url student_payment_url(student_payment, format: :json)
end
