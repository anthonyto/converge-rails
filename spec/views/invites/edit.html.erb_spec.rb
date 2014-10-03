require 'rails_helper'

RSpec.describe "invites/edit", :type => :view do
  before(:each) do
    @invite = assign(:invite, Invite.create!())
  end

  it "renders the edit invite form" do
    render

    assert_select "form[action=?][method=?]", invite_path(@invite), "post" do
    end
  end
end
