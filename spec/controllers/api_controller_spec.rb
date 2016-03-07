require 'rails_helper'
require 'pry'

RSpec.describe ApiController, type: :controller do

  before :each do
    request.env["HTTP_ACCEPT"] = 'application/json'
  end

  describe "GET 'events_for_day'" do
    let(:params) do
      {
        start: "3/26/1991"
      }
    end
    it "returns expected event for a given day" do
      get :events_for_day, params, {:format => :json}
      expect(JSON.parse(response.body).length).to eql 3
    end
  end

  describe "GET 'songs_for_day'" do
    let(:params) do
      {
        start: "3/29/1986"
      }
    end
    it "returns expected event for a given day" do
      get :songs_for_day, params
      expect(JSON.parse(response.body)["artist"]).to eq "Falco"
    end
  end

  describe "GET 'movie_for_day'" do
    let(:params) do
      {
        start: "1/5/1986"
      }
    end
    it "returns expected event for a given day" do
      get :movie_for_day, params
      expect(JSON.parse(response.body)["title"]).to eq "Rocky IV"
    end
  end

  describe "GET 'events_in_range'" do
    let(:params) do
      {
        start: "1/5/1986",
        end: "1/20/1986"
      }
    end
    it "returns expected event for a given day" do
      get :events_in_range, params
      expect(JSON.parse(response.body).length).to eq 5
    end
  end

  describe "GET 'songs_in_range'" do
    let(:params) do
      {
        start: "1/5/1986",
        end: "1/20/1986"
      }
    end
    it "returns expected event for a given day" do
      get :songs_in_range, params
      expect(JSON.parse(response.body).length).to eq 2
    end
  end

  describe "GET 'movies_in_range'" do
    let(:params) do
      {
        start: "1/5/1986",
        end: "1/20/1986"
      }
    end
    it "returns expected event for a given day" do
      get :movies_in_range, params
      expect(JSON.parse(response.body).length).to eq 3
    end
  end

end
