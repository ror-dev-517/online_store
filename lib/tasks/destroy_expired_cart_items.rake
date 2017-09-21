## rake destroy:expired_cart_items

namespace :destroy do
  desc "Destroy cart items which expirs after 2 days."
  task :expired_cart_items => :environment do
    Cart.where(updated_at < ?", 2.days.ago).delete_all
  end
end