# Setup instructions:
  - bundle install
  - rake db:create
  - rake db:migrate
  - rake db:seed
  - or rake db:setup (if you dont want to run above 3 commands seperately)
  - whenever
  - rails server

# Gems used:
  - pg (for postgres database, for reference checkout config/database.example file.)
  - devise (for users authentication)
  - rails_admin (to mange produts, users etc.)
  - twitter-bootstrap-rails (for HTML UI and design)
  - whenever (To schedule cron jobs)
  - pry (for debugging)

# Notes:
  - User can add products in cart without loging into the system.
  - When user click on Checkout the system will ask user for login.
  - Products which were added to cart earlier bye user and if the price of that product is changed the system will notify user about the change and the cart will get recalculated based on new new price.
  - There is an cron job script which checks cart table and deletes all entries which are older than 2 days from the time of script execution.
  - You can access admin panel fto manage products, users etc. by visiting following URL(currently this url doesn't require any admin authentication).
    `http://{HOST NAME WITH PORT}/admin e.g. http://localhost:3000/admin`