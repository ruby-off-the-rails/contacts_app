class Api::ContactsController < ApplicationController
  def show_me_the_contact
    @contact = Contact.first
    render 'contact.json.jb'
  end
end
