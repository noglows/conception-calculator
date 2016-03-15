require 'rails_helper'
require 'pry'

RSpec.describe ApiController, type: :controller do

  before :each do
    request.env["HTTP_ACCEPT"] = 'application/json'
  end

  describe "GET 'on_this_day'" do
    let(:event_params) do
      {
        date: "3/26/1991",
        type: "event"
      }
    end
    let(:song_params) do
      {
        date: "3/29/1986",
        type: "song"
      }
    end
    let(:movie_params) do
      {
        date: "1/5/1986",
        type: "movie"
      }
    end
    let(:null_song) do
      {
        date: "1/5/1986",
        type: "song"
      }
    end
    let(:null_movie) do
      {
        date: "1/6/1986",
        type: "movie"
      }
    end
    let(:null_event) do
      {
        date: "1/2/1986",
        type: "event"
      }
    end
    it "returns expected event for a given day" do
      get :on_this_day, event_params, {:format => :json}
      expect(JSON.parse(response.body).length).to eql 3
    end
    it "returns expected song for a given day" do
      get :on_this_day, song_params, {:format => :json}
      expect(JSON.parse(response.body)[0]["artist"]).to eq "Falco"
    end
    it "returns expected movie for a given day" do
      get :on_this_day, movie_params, {:format => :json}
      expect(JSON.parse(response.body)[0]["title"]).to eq "Rocky IV"
    end
    it "handles a null movie day as expected" do
      get :on_this_day, null_movie, {:format => :json}
      expect(JSON.parse(response.body)[0]).to eq nil
    end
    it "handles a null song day as expected" do
      get :on_this_day, null_song, {:format => :json}
      expect(JSON.parse(response.body)[0]).to eq nil
    end
    it "handles a null event day as expected" do
      get :on_this_day, null_event, {:format => :json}
      expect(JSON.parse(response.body)[0]).to eq nil
    end
  end

  describe "GET 'on_this_day_range'" do
    let(:event_range_params) do
      {
        start: "1/5/1986",
        end: "1/20/1986",
        type: "event"
      }
    end
    let(:song_range_params) do
      {
        start: "1/5/1986",
        end: "1/20/1986",
        type: "song"
      }
    end
    let(:movie_range_params) do
      {
        start: "1/5/1986",
        end: "1/20/1986",
        type: "movie"
      }
    end
    let(:null_event_range) do
      {
        start: "1/2/1986",
        end: "1/8/1986",
        type: "event"
      }
    end
    let(:null_song_range) do
      {
        start: "1/5/1986",
        end: "1/10/1986",
        type: "song"
      }
    end
    let(:null_movie_range) do
      {
        start: "1/6/1986",
        end: "1/11/1986",
        type: "movie"
      }
    end

    it "returns the expected events for a given range" do
      get :on_this_day_range, event_range_params
      expect(JSON.parse(response.body).length).to eq 6
    end
    it "returns the expected songs for a given range" do
      get :on_this_day_range, song_range_params
      expect(JSON.parse(response.body).length).to eq 2
    end
    it "returns the expected movies for a given range" do
      get :on_this_day_range, movie_range_params
      expect(JSON.parse(response.body).length).to eq 3
    end
    it "returns a null response for a range with no events" do
      get :on_this_day_range, null_event_range
      expect(JSON.parse(response.body)).to eq []
    end
    it "returns a null response for a range with no songs" do
      get :on_this_day_range, null_song_range
      expect(JSON.parse(response.body)).to eq []
    end
    it "returns a null response for a range with no events" do
      get :on_this_day_range, null_movie_range
      expect(JSON.parse(response.body)).to eq []
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
