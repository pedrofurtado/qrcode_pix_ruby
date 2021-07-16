FROM ruby:3.0.0-alpine
RUN apk update && apk add git
WORKDIR /app
COPY Gemfile Gemfile
COPY config.ru config.ru
RUN bundle install && bundle add webrick
CMD bundle exec rackup -p 3000 --host 0.0.0.0
