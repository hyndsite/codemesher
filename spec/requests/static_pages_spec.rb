require 'spec_helper'

describe "Static Pages" do
  describe "Help page" do
    before { visit help_path}
    subject {page}
    it "Should have the content 'Help'" do
      should have_selector('title', :text => 'CodeMesher:  Mesh your CodeMash Experience | Help')
    end

    it "Should have the Header content" do
      should have_selector('h1', text: 'Help')
    end
  end
end
