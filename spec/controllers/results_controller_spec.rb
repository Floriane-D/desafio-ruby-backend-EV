require "rails_helper"

RSpec.describe ResultsController, type: :controller do
  before(:each) do
    @competition = Competition.create(name: "Discus throw", unit: "m")
    @athlete = Athlete.create(name: "Gabriele Reinsch")
  end

  let(:valid_session) { {} }

  let(:valid_attributes) {
    {
      competition_id: @competition.id,
      athlete_id: @athlete.id,
      value: 76.8
    }
  }

  let(:invalid_attributes) {
    {
      competition_id: nil,
      athlete_id: nil,
      value: nil
    }
  }

  describe "Index" do
    it "returns all the results" do
      result = Result.create! valid_attributes
      get :index, params: { format: :json }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "Show" do
    it "returns the selected result" do
      result = Result.create! valid_attributes
      get :show, params: { format: :json , id: result.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "Create" do
    context "with valid params" do
      it "creates a new result" do
        expect {
          post :create, params: { format: :json }.merge(valid_attributes), session: valid_session
        }.to change(Result, :count).by(1)
      end
    end

    context "with invalid params" do
      it "returns errors" do
        post :create, params: { format: :json }.merge(invalid_attributes), session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "Destroy" do
    it "deletes the selected result" do
      result = Result.create! valid_attributes
      expect {
        delete :destroy, params: { format: :json, id: result.to_param }, session: valid_session
      }.to change(Result, :count).by(-1)
    end
  end
end
