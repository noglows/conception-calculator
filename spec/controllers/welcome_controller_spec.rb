require 'rails_helper'

RSpec.describe WelcomeController, type: :controller do
  describe "GET 'all events'" do
    it "renders the all_events page" do
      get :events
      expect(subject).to render_template :events
    end
  end

  describe "GET 'all songs'" do
    it "returns the all_songs page" do
      get :songs
      expect(subject).to render_template :songs
    end
  end

  describe "GET 'all movies'" do
    it "returns the all_movies page" do
      get :movies
      expect(subject).to render_template :movies
    end
  end


end
