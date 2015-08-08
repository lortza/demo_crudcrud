require 'rails_helper'

describe "layouts/application" do

  context "when a user is loggd in" do

    before do

      # Set our user instance variable so it's
      #   available to our `current_user` method
      #   when it gets called.
      user = create(:user)
      assign(:user, user)

      # Override our helper methods
      def view.signed_in_user?
        true
      end
      def view.current_user
        @user
      end

      # You might imagine that standard stubbing
      #   would work instead but it FAILS here because
      #   the `signed_in_user?` and `current_user`
      #   methods were never
      #   actually present on the `view` object
      #   and RSpec requires that stubs reflect 
      #   actual methods (it "verifies" them).
      # allow( view ).to receive( :signed_in_user? ).and_return( true )
      # allow( view ).to receive( :current_user ).and_return( user )

    end

    it "welcomes the current user in the navbar" do

      render
      expect( rendered ).to match(/Welcome\,.*!/)

    end
  end
end