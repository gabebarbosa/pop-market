json.extract! customer, :id, :name, :contact, :user_id, :created_at, :updated_at
json.url customer_url(customer, format: :json)
