class Api::ContactsController < ApplicationController
  def index
    # p "***" * 5
    # p current_user
    # p "***" * 5
    # @contacts = current_user.contacts
    @contacts = Contact.where(user_id: current_user.id)
    render 'index.json.jb'
  end

  def show
    @contact = Contact.find_by(id: params[:id])
    render 'show.json.jb'
  end

  def create
    # take in an address
    address = params[:address]
    # send that address to geocoder
    coordinates = Geocoder.coordinates(address)
    # get back lat/lng
    latitude = coordinates[0]
    longitude = coordinates[1]
    # save the lat/lng

    @contact = Contact.new(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      bio: params[:bio],
      lat: latitude,
      lng: longitude,
      user_id: current_user.id
    )
    if @contact.save
      render 'show.json.jb'
    else
      render json: {errors: @contact.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    @contact = Contact.find_by(id: params[:id])
    @contact.update(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      bio: params[:bio],
      phone_number: params[:phone_number]
    )
    render 'show.json.jb'
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy
    render json: {message: "contact removed"}
  end
end
