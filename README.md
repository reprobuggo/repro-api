# Repro API

Well hello! This is the API side of https://repro.run. Like its creators, it's a work in progress.

`repro-api` is an [API-only Rails app](https://guides.rubyonrails.org/api_app.html). It's designed to be paired with a separate application (and perhaps some day, multiple applications 🔮) for non-programmatic interaction, like viewing and clicking on stuff in a web browser. That first separate application is [`repro-web`](https://github.com/reprobuggo/repro-web/).

## Development

### Getting Started

1. Ensure you have the right version of ruby installed. See `.tool-versions`. [`asdf`](https://github.com/asdf-vm/asdf) is the recommended version manager.
2. `bundle`, to install dependencies
3. `rake db:create`, to create the databases
4. `rake db:migrate`, to run migrations
5. `rails s` to start the server

Now, while you can certainly run `repro-api` on its own, you may want to go ahead and run `repro-web` alongside it.

### Running the specs

`bundle exec rspec`
