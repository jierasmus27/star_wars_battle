require 'rails_helper'

RSpec.describe NewSeriesPeopleController, type: :controller do
  let(:new_series_person) {create(:new_series_person)}
  let(:new_series_person_params) { (build :new_series_person).attributes.symbolize_keys }

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      expect(response).to be_success
    end

    it "renders the new template" do
      get 'new'
      expect(response).to render_template(:new)
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      get 'show', id: new_series_person.id
      expect(response).to be_success
    end

    it "renders the show template" do
      get 'show', id: new_series_person.id
      expect(response).to render_template(:show)
    end
  end

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end

    it "assigns an array of NewSeriesPeople" do
      new_series_people = NewSeriesPerson.all
      get 'index'
      expect(assigns(:new_series_people)).to eq(new_series_people)
    end

    it "renders the index template" do
      get 'index'
      expect(response).to render_template(:index)
    end
  end

  describe "POST 'create'" do
    it "creates new_series_person" do
      expect { post :create, :new_series_person => new_series_person_params }.to change(NewSeriesPerson, :count).by(1)
    end

    it "assigns a newly created new_series_person as @new_series_person" do
      post :create, :new_series_person => new_series_person_params
      expect(assigns(:new_series_person)).to be_a(NewSeriesPerson)
    end

    it "redirects to the new new_series_person" do
      post :create, :new_series_person => new_series_person_params
      expect(response).to redirect_to(new_series_person_path(assigns(:new_series_person)))
    end
  end

  describe "DELETE 'destroy'" do
    it "removes object from array of NewSeriesPeople" do
      new_person = create(:new_series_person)
      expect{ delete :destroy, :id => new_person.id }.to change(NewSeriesPerson, :count).by(-1)
    end

    it "renders the index template" do
      delete 'destroy', id: new_series_person.id
      expect(response).to redirect_to(new_series_people_path)
    end
  end
end
