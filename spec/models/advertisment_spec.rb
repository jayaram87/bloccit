require 'rails_helper'

RSpec.describe Advertisment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  
  let(:advertisment) {Advertisment.create!(title: "New Ad Title", body: "New Ad body", price: 100)}
  
  describe "attributes" do
    it "responds to title" do
        expect(advertisment).to respond_to(:title)
    end
    
    it "responds to body" do
        expect(advertisment).to respond_to(:body)
    end
    
    it "responds to price" do
        expect(advertisment).to respond_to(:price)
    end
        
  end
  
end
