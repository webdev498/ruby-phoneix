json.array!(@pricebreaks) do |pricebreak|
  json.extract! pricebreak, :id, :dept_number, :schedule_number, :pct_or_amount, :break_limit, :markup_pct, :markup_amount
  json.url pricebreak_url(pricebreak, format: :json)
end
