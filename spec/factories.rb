FactoryGirl.define do

  factory :user do
    name "Foo"
    email { "#{name}@bar.com" }
    password "foobarfoobar"
  end

end