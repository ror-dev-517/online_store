RSpec.describe ProductsController, type: :controller do
  describe "GET 'index'" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end

    it 'should render index page' do
      get :index
      expect(response).to render_template('index')
    end

    it 'should return all products' do
      3.times do
        FactoryGirl.create(:product)
      end
      get :index
      expect(assigns(:products).count).to eq(3)
    end
  end
end