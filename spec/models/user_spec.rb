require 'rails_helper'
describe User do
  # remember you'll need to include the line
  # `config.include FactoryGirl::Syntax::Methods`
  # in your `factory_girl.rb` config to avoid having
  # to call `build` using `FactoryGirl.build` here
  let(:user){ build(:user) }

  it "is valid with default attributes" do
    expect(user.valid?).to eq(true)
  end

  it "saves with default attributes" do
    expect{ user.save! }.to_not raise_error
  end

  context "when saving multiple users" do
    before do
      user.save!
    end
    it "doesn't allow identical email addresses" do
      # build a new user with the old email
      new_user = build(:user, :email => user.email)
      expect(new_user.valid?).to eq(false)
    end
  end

  it "responds to the posts association" do
    expect(user).to respond_to(:posts)
  end

  describe "#post_count" do
    let(:num_posts){ 3 }
    before do
      # Note we could use some of Factory Girl's
      # "transient" helpers, but...
      # we'll keep things explicit for now
      user.posts = create_list(:post, num_posts)
      # Don't forget to save the user after setting
      # a new attribute or re-assigning an association!
      user.save!
    end
    it "returns the count of a User's posts" do
      expect(user.post_count).to eq(num_posts)
    end
  end
end
