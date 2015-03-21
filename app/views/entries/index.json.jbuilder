json.array!(@entries) do |entry|
  json.extract! entry, :id, :amount, :date, :user_id, :category_id
  json.url entry_url(entry, format: :json)
end
