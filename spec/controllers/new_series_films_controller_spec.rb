require 'rails_helper'

RSpec.describe NewSeriesFilmsController, type: :controller do
  let(:new_series_film) {create(:new_series_film)}
  let(:new_series_film_params) { (build :new_series_film).attributes.symbolize_keys }

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

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      expect(response).to be_success
    end

    it "renders the index template" do
      get 'index'
      expect(response).to render_template(:index)
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      new_series_film = create(:new_series_film)
      get 'show', id: new_series_film.id
      expect(response).to be_success
    end

    it "renders the show template" do
      new_series_film = create(:new_series_film)
      get 'show', id: new_series_film.id
      expect(response).to render_template(:show)
    end
  end

  describe "POST 'create'" do
    it "creates new_series_film" do
      expect { post :create, :new_series_film => new_series_film_params }.to change(NewSeriesFilm, :count).by(1)
    end

    it "assigns a newly created circuit as @circuit" do
      post :create, :new_series_film => new_series_film_params
      expect(assigns(:new_series_film)).to be_a(NewSeriesFilm)
    end

    it "redirects to the parent notice" do
      post :create, :new_series_film => new_series_film_params
      expect(response).to redirect_to(new_series_film_path(assigns(:new_series_film)))
    end

  end
end
