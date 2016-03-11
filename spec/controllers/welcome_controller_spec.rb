require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "GET 'user_page'" do
    let(:params) do
      {
        id: '19910321'
      }

    end
    it "renders the user details page" do
      get :user_page, params
      expect(subject).to render_template :user_page
    end
  end

  describe "GET 'letsencrypt'" do
    it "returns the expected responsse" do
      get :letsencrypt
      expect(response.status).to eq 200
    end
  end
  #
  # describe "GET 'all songs'" do
  #   it "returns the all_songs page" do
  #     get :songs
  #     expect(subject).to render_template :songs
  #   end
  # end
  #
  # describe "GET 'all movies'" do
  #   it "returns the all_movies page" do
  #     get :movies
  #     expect(subject).to render_template :movies
  #   end
  # end


end
