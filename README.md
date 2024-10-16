# POPMENU TEST

This is a simple test api

## Tools
- Ruby 3.3.4
- Rails 7.2.1
- SQLite
- Docker
- Rspec

## Thinking out loud

When adding the `Restaurant` model with the new relationship between restaurants and menus I had two options in the endpoints:
1. Keep as is and only looking for restaurant with a new param
2. Change the routes/controllers to make the restaurant_id required through the route instead of just pass it as a param

I decided to go with option 2 and this added a break change for the project, since it's a test I think it's ok, if it was a live project we would probably need to think better approach, maybe an API versioning?