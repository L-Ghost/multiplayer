# MULTIPLAYER

Video Games application where you arrange a date and a place to play your beloved games with your friends.

## Setup

You need to have **Docker** installed in your machine. Run the following command to setup everything. It will build the containers for the application, the database and the background tasks.

 - docker-compose up -d

After that access the *web* container and run the commands necessary to create the database:

 - rails db:create
 - rails db:migrate
 - rails db:seed

Then access from your localhost the port reserved for the *web* container in *docker-compose.yml* to see the application running.