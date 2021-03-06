class Api::ContactsController < ApplicationController
  def index
    # p "***" * 5
    # p current_user
    # p "***" * 5
    # @contacts = current_user.contacts
    # @contacts = Contact.where(user_id: current_user.id)


    # # find a category
    # group = Group.find_by(name: params[:name])
    # # find all the contacts from that group
    # @contacts = group.contacts.where(user_id: current_user.id)
    @contacts = Contact.all
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
    # coordinates = Geocoder.coordinates(address)
    # # get back lat/lng
    # latitude = coordinates[0]
    # longitude = coordinates[1]
    # save the lat/lng

    @contact = Contact.new(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      bio: params[:bio],
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
    @contact.update!(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      bio: params[:bio],
      phone_number: params[:phone_number],
      user_id: current_user.id
    )

    # how is this broken?
    # why didn't i add user_id? how did I not know until now?

    # how did it work earlier when I tested it in insomnia?
    render 'show.json.jb'
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy
    render json: {message: "contact removed"}
  end
end



def index
  @contact = Contact.all
  render 'index.json.jb'
end


def create
  @contact = Contact.new(
      first_name: params[:first_name],
      middle_name: params[:middle_name],
      last_name: params[:last_name],
      email: params[:email],
      phone_number: params[:phone_number],
      bio: params[:bio]
    )
  @contact.save
  render 'show.json.jb'
end
