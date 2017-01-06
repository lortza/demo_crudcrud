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

  factory :comment do
    body "Foo Comment Body"
    author                # association!

    # to make comments for other types of commentables,
    # use a nested factory
    association :commentable, factory: :post  
  end
end