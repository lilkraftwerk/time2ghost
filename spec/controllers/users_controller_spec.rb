require 'spec_helper'

describe UsersController do
  let!(:test_user){FactoryGirl.create(:user)}

  context "#show" do
    it "renders show page" do
      get :show, test_user.attributes
      expect(response).to redirect_to(root_path)
    end
  end

  context "#new" do
    it "makes empty user for new user form" do
      get :new
      expect(assigns(:user).attributes).to eq(User.new.attributes)
    end
  end

  context "#create" do
    it "creates a new user" do
      expect {
        post :create, :user => FactoryGirl.attributes_for(:user)
      }.to change { User.count }.by(1)
    end

    it "redirects after creating new user" do
      post :create, :user => FactoryGirl.attributes_for(:user)
      expect(response).to redirect_to(:root)
    end

    it "redirects back to new user signup page on bad params" do
      post :create, :user => { username: "thedoge", password: "123", phone_number: "1231231233", email: "doge5@doge.com" }
      expect(response).to redirect_to(new_user_path)
    end
  end

  context "#update" do
    it "correctly updates the user" do
      @attributes = {username: "doge2.0", password: "password", email: "doge@doge.doge", phone_number: "8675309"}
      put :update, :id => test_user.id, :user => @attributes
      test_user.reload
      expect(test_user.username).to eql("doge2.0")
    end
  end

  context "#edit" do
    it "correctly finds user on edit user request" do
      get :edit, :id => test_user.id
      expect(response).to eq(test_user)
    end
  end

end