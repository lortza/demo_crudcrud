class PhotosController < ApplicationController

  def new
    @photo = Photo.new
  end

  def show
    @photo = Photo.find(params[:id])
  end

  def serve
    @photo = Photo.find(params[:photo_id])
    send_data(@photo.data, :type => @photo.mime_type, :filename => "#{@photo.filename}.jpg", :disposition => "inline")
  end

  def create
    # build a photo object with `new` and any non-data
    # attributes that have been passed in
    # then pass it into the block to set the
    # additional data-based attributes if they're present
    # Use model validations to verify this on save!
    @photo = Photo.new(photo_params.except(:data)) do |t|
      if photo_params[:data]
        t.data      = photo_params[:data].read
        t.filename  = photo_params[:data].original_filename
        t.mime_type = photo_params[:data].content_type
      end
    end

    if @photo.save
      redirect_to(@photo, :notice => 'Photo was successfully created.')
    else
      render :action => "new"
    end
  end

  private
  def photo_params
    params.require(:photo).permit(:data)
  end

end
