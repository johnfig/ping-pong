FactoryGirl.define do
  factory :user do
    first_name 'John'
    last_name 'Fig'
    username 'johnfig'
    password 'password'
    password_confirmation 'password'
    avatar_file_name "anything"
    avatar_content_type "image/jpeg"
    avatar_file_size 1
    avatar_updated_at Time.now
  end
end
