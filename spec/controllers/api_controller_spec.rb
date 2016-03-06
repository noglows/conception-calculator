require 'rails_helper'

RSpec.describe ApiController, type: :controller do

  describe "GET 'events_for_day'" do
    let(:params) do
      {
        start: "3/21/1991"
      }
    end
    it "returns expected event for a given day" do
      get :event
      expect(response).to eq 2
    end
  end


    describe "GET 'songs_for_day'" do
      let(:params) do
        {
          start: "3/21/1991"
        }
      end
      it "returns expected event for a given day" do
        get :song
        expect(response).to eq 2
      end
    end

end
