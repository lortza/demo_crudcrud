require 'rails_helper'

describe 'UsersRequests' do
  describe 'user access' do
    let(:user){ create(:user) }

    # Log in the easy way -- we can send
    # a http request directly to the session controller
    # This will work for session or cookie-based auth
    before :each do 
      post sessions_path, params: { email: user.email, password: user.password }
    end

    describe 'GET #index' do
      it "allows a user to visit" do
        get users_path
        expect(response).to be_success
      end
    end

    describe 'GET #new' do
      it "GET #new works when logged in" do
        get new_user_path
        expect(response).to be_success
      end
    end

    describe 'GET #show' do
      it "GET #show works as normal when logged in" do
        get user_path(user)
        expect(response).to be_success
      end
    end

    describe 'GET #edit' do
      it "GET #edit works as normal" do
        get edit_user_path(user)
        expect(response).to be_success
      end

      it "for another user denies access" do
        # make sure this other user actually exists
        another_user = create(:user)
        get edit_user_path(another_user)

        expect(response).to redirect_to root_path
      end
    end

    describe "POST #create" do
      it "redirects after creating the new user" do
        # Send in the attributes of a user (from our factory)
        #   as if we'd submitted them in a `form_for` form
        post users_path, params: { :user => attributes_for(:user) }

        # Now expect a redirect instead of a render
        expect(response).to have_http_status(:redirect)
      end

      it "actually creates the user" do
        expect{
          post users_path, params: { user: attributes_for(:user) }
        }.to change(User, :count).by(1)
      end

      # Note that we're testing only for the type of flash instead 
      # of the message, which would make the test more brittle
      it "creates a flash message" do
        post users_path, params: { :user => attributes_for(:user) }
        expect(flash[:success]).to_not be_nil
      end

      it "sets an auth token cookie" do
        post users_path, params: { :user => attributes_for(:user) }
        expect(response.cookies["auth_token"]).to_not be_nil
      end
    end

    describe "PATCH #update" do

      # Do this nudge to make sure our `let` user actually
      # gets called before the tests to ensure that user
      # is persisted.  Otherwise, it might not persist 
      # until midway through or after a test.  This is lazy
      # `let(:user)` doing its job.  We could have switched
      # to eager `let!(:user)` above but... don't feel like it.
      # Also, this may not be relevant since our login in
      # the top-level `before` block will force the user to
      # evaluate, but we might change that later and don't
      # want our whole test to blow up.
      before { user }

      context "with valid attributes" do

        let(:updated_name){ "updated_foo" }

        # Note that this isn't being mocked out
        it "actually updates the user" do
          put user_path(user), params: {
            :user => attributes_for(
              :user, 
              :name => updated_name)
          }
          # This won't work properly if you don't reload!!!
          # The user in that case would be the same one
          # you set in the `let` method
          user.reload
          expect(user.name).to eq(updated_name)
        end

        it "redirects to the updated user" do
          # Send in the attributes of a user 
          # with a different name
          put user_path(user), params: {
            :user => attributes_for(
              :user,
              :name => updated_name)
          }
          expect(response).to redirect_to user_path(user)
        end
      end

      context "with invalid attributes" do
        # ...and so on
      end
    end

    describe "DELETE #destroy" do

      before { user }  # force let to evaluate

      it "destroys the user" do
        expect{
          delete user_path(user)
        }.to change(User, :count).by(-1)
      end

      it "redirects to the root" do
        delete user_path(user)
        expect(response).to redirect_to root_url
      end
      # ... and so on
    end
    # ... and so on
  end
end