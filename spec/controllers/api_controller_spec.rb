require 'rails_helper'

RSpec.describe ApiController, type: :controller do

  describe "GET 'events_for_day'" do
    let(:params) do
      {
        start: "3/21/1991"
      }
    end
    it "returns expected event for a given day" do
      @expected = {
            :flashcard  => @flashcard,
            :lesson     => @lesson,
            :success    => true
          }.to_json
      get :events_for_day, params, format: :json
      response.body.should == @expected
      #expect(response.body).to be_json_eql 2
    end
  end


  # describe "GET 'events_for_day'" do
  #   let(:params) do
  #     {
  #       start: "3/21/1991"
  #     }
  #   end
  #   it "returns expected event for a given day" do
  #     get :events_for_day, params
  #     expect(response.body).to be_json_eql 2
  #   end
  # end
  #
  #
  # describe "GET 'songs_for_day'" do
  #   let(:params) do
  #     {
  #       start: "3/21/1991"
  #     }
  #   end
  #   it "returns expected event for a given day" do
  #     get :songs_for_day, params
  #     binding.pry
  #     expect(response.body).to eq 2
  #   end
  # end

end
