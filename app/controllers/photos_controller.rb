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

    # OPTION 1: The Controller Way
    # 
    # This option does all the work in the controller.
    # 
    # We build a photo object by passing `new` our block 
    #   but only after stripping out the `data` param first.
    #   The block then takes care of handling the data.
    #
    # @photo = Photo.new(photo_params.except(:photo_data)) do |t|
    #   if photo_params[:photo_data]
    #     t.data      = photo_params[:photo_data].read
    #     t.filename  = photo_params[:photo_data].original_filename
    #     t.mime_type = photo_params[:photo_data].content_type
    #   end
    # end


    # OPTION 2: The Virtual Attribute Way
    #
    # This option relies on your model to have a 
    #   virtual setter which will handle processing
    #   the data from params.
    # The good thing about this approach is that it
    #  "just works" from the controller's perspective
    #  since you can just use `Photo.new` as normal
    # Just remember to permit your virtual attribute param!
    @photo = Photo.new(photo_params)

    if @photo.save
      redirect_to(@photo, :notice => 'Photo was successfully created.')
    else
      render :action => "new"
    end
  end

  private
  def photo_params
    params.require(:photo).permit(:photo_data)
  end

end
