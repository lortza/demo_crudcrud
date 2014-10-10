class FriendingsController < ApplicationController

  def create
    # For now, we'll just assume we can pull the 
    # current user from params because we haven't
    # talked about authentication.  In reality, you
    # would get the current_user from your authentication
    # system.
    current_user = User.find(params[:current_user_id])
    friending_recipient = User.find(params[:id])

    # Note that using the `<<` method isn't the only
    # way to do this, though it is quite elegant.
    # You could also utilize the join table directly
    # with something like 
    # current_user.friendings.build(:friend_id => friending_recipient.id)
    # and then attempt to save that
    if current_user.friended_users << friending_recipient
      flash[:success] = "Successfully friended #{friending_recipient.name}"
      redirect_to friending_recipient
    else
      flash[:error] = "Failed to friend!  Sad :("
      redirect_to friending_recipient
    end
  end

  def destroy
    # For now, we'll just assume we can pull the 
    # current user from params because we haven't
    # talked about authentication.  In reality, you
    # would get the current_user from your authentication
    # system.
    current_user = User.find(params[:current_user_id])
    unfriended_user = User.find(params[:id])

    # Locate the friendship we want to destroy BUT
    # ONLY within our current_user's friendships 
    # because otherwise it's a big security hole where
    # you could delete other people's friendships!
    # As above, you could do this multiple ways including
    # by directly locating the join table record and
    # destroying that.
    # In this case, we'll use the association `delete`
    # method to de-associate these Users.
    # No orphans were created in the making of this action :)
    current_user.friended_users.delete(unfriended_user)
    flash[:success] = "Successfully unfriended"
    redirect_to current_user
  end

end
