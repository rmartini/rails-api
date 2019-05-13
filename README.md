# Rails API Example

This application runs a simple example of a financial formula in order to calculate the fixed-term earnings given the amount and the selected period of a bank

# Installation

You'll need:

* Ruby 2.3.x or newer
* Rails 5.0.7.2
* PostgreSQL

# Running the application

```sh
bundle install --binstubs
./bin/rake db:migrate
puma -C config/puma.rb
```
o
```sh
bundle install --binstubs
./bin/rake db:migrate
./bin/rails server -p $PORT
```
o

```sh
docker-compose build
docker-compose run --rm api rake db:migrate
docker-compose up
```

# Running Test

```sh
bundle exec rspec
```

o

```sh
docker-compose run --rm api bundle exec rspec
```

# API Endpoints

All endpoints required the request header: "Accept": "application/vnd.api+json"

- GET /v1/banks
- GET /v1/banks/:id
- POST /v1/banks
  - data: { name: string }
- PUT /v1/banks/:id
- DELETE /v1/banks/:id
- GET /v1/banks/:bank_id/bank_periods
- GET /v1/banks/1/bank_periods/:id
- POST /v1/banks/:bank_id/bank_periods
  - data: { bank_id: [integer], percentage: [float], days: [integer], active: [boolean] }
- PUT /v1/banks/1/bank_periods:id
- DELETE /v1/banks/1/bank_periods/:id
- GET /v1/operations
- POST /v1/operations
  - data: { bank_period_id: [integer], amount: [float] }

You can execute any API Endpoint with curl command:

```sh
curl -H 'accept: application/vnd.api+json' -X [METHOD] -d [DATA] [SERVER]
```


### Documentation

* https://guides.rubyonrails.org/api_app.html
* https://scotch.io/tutorials/build-a-restful-json-api-with-rails-5-part-one
* https://sourcey.com/articles/building-the-perfect-rails-api
* https://docs.docker.com/compose/rails/
* https://medium.com/@nirmalyaghosh/9-steps-for-dockerizing-a-rails-api-only-application-d65a8836f3df
