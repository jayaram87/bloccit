require 'rails_helper'

RSpec.describe Post, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
  
  let(:post) {Post.create!(title: "New Post title", body: "New Post Body")}
  
  describe "attributes" do
    
    it "responds to title" do
        expect(post).to respond_to(:title)
    end
    
    it "responds to body" do
        expect(post).to respond_to(:body)
    end
    
  end
  
end
