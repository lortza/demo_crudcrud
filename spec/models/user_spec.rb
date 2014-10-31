require 'rails_helper'
describe User do
  # remember you'll need to include the line
  # `config.include FactoryGirl::Syntax::Methods`
  # in your `factory_girl.rb` config to avoid 
  # calling `build` using `FactoryGirl.build`
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
      new_user = build(:user, :email => user.email)
      expect(new_user.valid?).to eq(false)
    end
  end
end
