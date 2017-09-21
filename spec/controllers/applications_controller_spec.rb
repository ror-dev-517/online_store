require 'spec_helper'

RSpec.describe ApplicationController, type: :controller do
  describe 'before actions' do
    it { is_expected.to use_before_action(:set_cart_in_session) }
  end
end