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

  describe "GET 'send_email'" do
    it "successfully sends an email if correct params are provided" do
      get :send_email, "person" => "email@example.com", "sender" => "Jimmy Bean", "message" => "19910321"
      parsed_response = JSON.parse(response.body)
      expect(parsed_response[0]["flash"]).to eq "Email successfully sent to email@example.com"
      expect(response.status).to eq 200
    end
    it "returns an error message if something goes wrong" do
      get :send_email, "person" => "broken", "sender" => "Test", "message" => "19910321"
      parsed_response = JSON.parse(response.body)
      expect(parsed_response[0]["flash"]).to eq "Sorry, there's been an error."
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
