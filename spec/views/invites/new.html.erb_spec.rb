require 'rails_helper'

RSpec.describe "invites/new", :type => :view do
  before(:each) do
    assign(:invite, Invite.new())
  end

  it "renders new invite form" do
    render

    assert_select "form[action=?][method=?]", invites_path, "post" do
    end
  end
end
