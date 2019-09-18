FROM ruby:2.6-alpine

RUN gem i bundler

RUN mkdir /app

WORKDIR /app

COPY Gemfile* ./

RUN bundle install --without development
# TODO: only production

COPY . ./

CMD bundle exec rake
