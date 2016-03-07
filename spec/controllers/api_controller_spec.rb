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

  describe "GET 'conception_range'" do
    let(:params) do
      {
        birthday: "3/21/1991"
      }
    end

    let(:early_params) do
      {
        unusual: "true",
        birthday: "3/21/1991",
        number: 2,
        modifier: "early"
      }
    end

    let(:late_params) do
      {
        unusual: "true",
        birthday: "3/21/1991",
        number: 2,
        modifier: "late"
      }
    end

    it "returns a conception range for a normal birthday" do
      get :conception_range, params
      expect(JSON.parse(response.body)[0]).to eq "1990-06-25"
      expect(JSON.parse(response.body)[1]).to eq "1990-07-01"
    end

    it "returns a conception range for an early birthday" do
      get :conception_range, early_params
      expect(JSON.parse(response.body)[0]).to eq "1990-07-09"
      expect(JSON.parse(response.body)[1]).to eq "1990-07-15"
    end

    it "returns a conception range for a late birthday" do
      get :conception_range, late_params
      expect(JSON.parse(response.body)[0]).to eq "1990-06-11"
      expect(JSON.parse(response.body)[1]).to eq "1990-06-17"
    end
  end

  describe "GET 'get_youtube_id'" do
    let(:movie_params) do
      {
        type: "movie",
        title: "Lars and the Real Girl"
      }
    end

    let(:song_params) do
      {
        type: "song",
        title: "Your arms around me",
        artist: "Jens Lekman"
      }

    end

    it "returns correct video id for movie input" do
      get :get_youtube_id, movie_params
      expect(JSON.parse(response.body)[0]).to eq "XNcs9DrKYRU"
    end

    it "returns correct video id for movie input" do
      get :get_youtube_id, song_params
      expect(JSON.parse(response.body)[0]).to eq "NIwIAbcLFhI"
    end
  end


end
