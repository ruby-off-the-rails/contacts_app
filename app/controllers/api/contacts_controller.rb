class Api::ContactsController < ApplicationController
  def show_me_the_contact
    render 'contact.json.jb'
  end
end
