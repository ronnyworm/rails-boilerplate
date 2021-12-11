FROM ruby:2.4

RUN apt-get update -qq && apt-get install -y graphviz

WORKDIR /rails-app
COPY . home/
WORKDIR /rails-app/home

EXPOSE $RAILS_PORT

RUN bundle install

CMD ["/rails-app/home/idle.sh"]