# Wintathon2019

`bundle install`

`bin/rake db:drop db:create db:migrate db:seed`


`yarn install`

`npm install`

`export GOOGLE_APPLICATION_CREDENTIALS="/home/atibhi/Desktop/Wintathon2019/wintathon-b86a26e78085.json"
`

`bin/webpack-dev-server`

To run server

`rails s`

#### To access as admin

Go to rails console. Type `rails c` on console.

then do the following to set first user as admin.

`>u = User.first`

`>u.admin = true`

`>u.save`

`>exit`

Now refresh page, you should find link to admin dashboard.

