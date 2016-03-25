require 'rails_helper'

RSpec.describe SponsorpostsController, type: :controller do
  
  let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}
  let(:my_sponsorpost) { SponsorPost.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 80) }

  describe "GET show" do
   it "returns http success" do
      get :show, topic_id: my_topic.id, id: my_sponsorpost.id
      
      expect(response).to have_http_status(:success)
    end
    
    it "renders the #show view" do
       get :show, topic_id: my_topic.id, id: my_sponsorpost.id
       
       expect(response).to render_template :show
    end
    
    it "assigns my_sponsorpost to @sponsor_post" do
       get :show, topic_id: my_topic.id, id: my_sponsorpost.id

       expect(assigns(:sponsor_post)).to eq(my_sponsorpost)
     end
     
  end

  describe "GET new" do
    it "returns http success" do
       get :new, topic_id: my_topic.id
       
       expect(response).to have_http_status(:success)
     end
     
     it "renders the #new view" do
       get :new, topic_id: my_topic.id
       
       expect(response).to render_template :new
     end
     
     it "instantiates @sponsor_post" do
       get :new, topic_id: my_topic.id
       
       expect(assigns(:sponsor_post)).not_to be_nil
     end
  end
  
  describe "POST create" do
     it "increases the number of sponsor posts by 1" do
       expect{post :create, topic_id: my_topic.id, sponsor_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 80}}.to change(SponsorPost, :count).by(1)
     end
    
     it "assigns the new sponsor post to @sponsor_post" do
       post :create, topic_id: my_topic.id, sponsor_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 80}
       
       expect(assigns(:sponsor_post)).to eq SponsorPost.last
     end
     
    it "redirects to the new sponsor post" do
      post :create, topic_id: my_topic.id, sponsor_post: {title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 80}
      
      expect(response).to redirect_to [my_topic, SponsorPost.last]
    end
    
   
   end

  describe "GET edit" do
     it "returns http success" do
       get :edit, topic_id: my_topic.id, id: my_sponsorpost.id
       expect(response).to have_http_status(:success)
     end
     
     it "renders the #edit view" do
       get :edit, topic_id: my_topic.id, id: my_sponsorpost.id
       expect(response).to render_template :edit
     end
     
     it "assigns sponsor post to be updated to @sponsor_post" do
       get :edit, topic_id: my_topic.id, id: my_sponsorpost.id
       sp_instance = assigns(:sponsor_post)
       
       expect(sp_instance.id).to eq my_sponsorpost.id
       expect(sp_instance.title).to eq my_sponsorpost.title
       expect(sp_instance.body).to eq my_sponsorpost.body
       expect(sp_instance.price).to eq my_sponsorpost.price
     end
     
  end
  
  describe "PUT update" do
     it "updates sponsor post with expected attributes" do
       new_title = RandomData.random_sentence
       new_body = RandomData.random_paragraph
       new_price = rand(80..100)

       put :update, topic_id: my_topic.id, id: my_sponsorpost.id, sponsor_post: {title: new_title, body: new_body, price: new_price}

       updated_sp = assigns(:sponsor_post)
       expect(updated_sp.id).to eq my_sponsorpost.id
       expect(updated_sp.title).to eq new_title
       expect(updated_sp.body).to eq new_body
       expect(updated_sp.price).to eq new_price
     end

     it "redirects to the updated sponsor post" do
       new_title = RandomData.random_sentence
       new_body = RandomData.random_paragraph
       new_price = rand(80..100)

       put :update, topic_id: my_topic.id, id: my_sponsorpost.id, sponsor_post: {title: new_title, body: new_body, price: new_price}
       
       expect(response).to redirect_to [my_topic, my_sponsorpost]
     end
   end

end
