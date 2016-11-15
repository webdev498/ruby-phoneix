json.array!(@licenses) do |license|
  json.extract! license, :id, :dept_number, :license_title, :license_text
  json.url license_url(license, format: :json)
end
