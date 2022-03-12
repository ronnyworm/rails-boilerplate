FROM ruby:2.7

RUN apt-get update -qq && apt-get install -y sqlite3 graphviz

WORKDIR /usr/app
COPY . .
EXPOSE $RAILS_PORT

CMD ["sh", "/usr/app/idle.sh"]