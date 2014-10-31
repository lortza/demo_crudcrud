FactoryGirl.define do

  # NOTE: We'll be changing this in a minute
  # so don't just copy-paste it into your code
  factory :user, :aliases => [:author] do
    sequence(:name){ |n| "Foo#{n}"}
    email { "#{name}@bar.com" }
    password "foobarfoobar"
  end

  factory :post do
    title "Foo Post"
    body "Foo Post Body"
    author                # association!
  end
end