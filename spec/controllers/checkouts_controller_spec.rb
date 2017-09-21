RSpec.describe CheckoutsController, type: :controller do

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

  describe 'POST place_order' do
    it 'successfully placed order then redirect to root' do
      post :place_order
      expect(response).to redirect_to(root_path)
    end

    it 'not saved order then redirect to root' do
      allow_any_instance_of(Order).to receive(:save).and_return(false)
      post :place_order
      expect(response).to redirect_to(root_path)
    end
  end
end