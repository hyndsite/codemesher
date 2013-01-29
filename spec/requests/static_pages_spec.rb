require 'spec_helper'

describe "Static Pages" do
  describe "Help page" do
    it "Should have the content 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('title', :text => 'CodeMesher:  Mesh your CodeMash Experience | Help')
    end
  end
end
