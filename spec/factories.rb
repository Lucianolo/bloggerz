FactoryGirl.define do
  factory :user do
    email 'test@example.com'
    password 'f4k3p455w0rd'

    sign_in_count '1'
    
    created_at '1231'
    updated_at '2131'
  end
end