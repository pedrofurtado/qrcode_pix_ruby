FROM ruby:3.0.0-alpine
RUN apk update && apk add git
RUN mkdir -p /app/
WORKDIR /app/
VOLUME /app/
COPY . /app/
RUN bundle install
CMD bundle exec rake
