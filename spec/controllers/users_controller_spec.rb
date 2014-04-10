require 'spec_helper'

describe UsersController do
  let!(:test_user){FactoryGirl.create(:user)}

  context "#show" do
    it "renders show page" do
      get :show, test_user.attributes
      expect(response).to render_template(:show)
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
      expect(response).to be_redirect
    end
  end
end