RSpec.describe CartsController, type: :controller do

  describe 'before actions' do
    it { is_expected.to use_before_action(:authenticate_user!) }
  end

  before do
    @user = FactoryGirl.create(:user)
    @cart = FactoryGirl.create(:cart, user: @user)
    @order = FactoryGirl.create(:order, user: @user)
    @order_item = FactoryGirl.create(:order_item, order: @order)
    @product = FactoryGirl.create(:product)
    sign_in @user
  end

  describe "GET 'index'" do
    it "returns http success" do
      get :index
      expect(response).to be_success
    end

    it 'should render index page' do
      get :index
      expect(response).to render_template('index')
    end

    it 'should return all cart items' do
      get :index
      expect(assigns(:cart_products).count).to eq(1)
    end

    it 'should return all cart items' do
      get :index
      expect(assigns(:cart_products).count).to eq(1)
    end

    it 'should return all cart items on current user' do
      get :index
      expect(assigns(:cart_products).count).to eq(1)
    end

    it 'should return all cart items without current user' do
      allow(controller).to receive(:current_user).and_return(nil)
      session[:cart] ||= {}
      session[:cart][@product.id.to_s] = {
        'quantity' => 1,
        'price' => 10
      }
      get :index
      expect(assigns(:cart_products).count).to eq(1)
    end
  end

  describe "GET 'add_to_cart'" do
    it "incremented cart count" do
      xhr :post, :add_to_cart, { product_id: @product.id }
      expect(Cart.all.count).to eq(2)
      expect(response).to be_success
    end
  end

  describe "GET 'destroy_cart_item'" do
    it "decrement cart count" do
      cart = FactoryGirl.create(:cart, user: @user, product: @product)
      post :destroy_cart_item, { product_id: @product.id }
      expect(Cart.count).to eq(1)
      expect(response).to redirect_to(carts_path)
    end
  end

  describe "GET 'checkout'" do
    it "returns http success" do
      get :checkout
      expect(response).to be_success
    end

    it 'should return all cart items' do
      get :checkout
      expect(assigns(:cart_products).count).to eq(1)
    end

    it 'should return all cart items' do
      get :checkout
      expect(assigns(:cart_products).count).to eq(1)
    end
  end
end