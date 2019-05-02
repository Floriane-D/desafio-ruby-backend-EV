require "rails_helper"

RSpec.describe CompetitionsController, type: :controller do
  let(:valid_session) { {} }

  let(:valid_attributes) {
    {
      name: "Triple Jump",
      unit: "m"
    }
  }

  let(:invalid_attributes) {
    {
      name: nil,
      unit: nil,
      finished: nil,
      max_number_of_attempts: nil,
      criteria_to_win: nil
    }
  }

  describe "Index" do
    it "returns all the competitions" do
      competition = Competition.create! valid_attributes
      get :index, params: { format: :json }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "Show" do
    it "returns the selected competition" do
      competition = Competition.create! valid_attributes
      get :show, params: { format: :json, id: competition.to_param }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "Create" do
    context "with valid params" do
      it "creates a new competition" do
        expect {
          post :create, params: { format: :json }.merge(valid_attributes), session: valid_session
        }.to change(Competition, :count).by(1)
      end
    end

    context "with invalid params" do
      it "returns errors" do
        post :create, params: { format: :json }.merge(invalid_attributes),
          session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "Update" do
    context "with valid params" do
      let(:updated_attributes) {
        {
          name: "400m race"
        }
      }

      it "updates the selected competition" do
        competition = Competition.create! valid_attributes
        patch :update, params: { format: :json, id: competition.to_param }.merge(updated_attributes), session: valid_session
        competition.reload
        expect(competition.name).to eq(updated_attributes[:name])
      end
    end

    context "with invalid params" do
      it "returns errors" do
        competition = Competition.create! valid_attributes

        patch :update, params: { format: :json, id: competition.to_param }.merge(invalid_attributes), session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "Finish" do
    it "marks the competition as finished" do
      competition = Competition.create! valid_attributes
      patch :finish, params: { format: :json, id: competition.to_param }, session: valid_session
      competition.reload
      expect(competition.finished).to eq(true)
    end
  end

  describe "Destroy" do
    it "deletes the selected competition" do
      competition = Competition.create! valid_attributes
      expect {
        delete :destroy, params: { format: :json, id: competition.to_param }, session: valid_session
      }.to change(Competition, :count).by(-1)
    end
  end
end
