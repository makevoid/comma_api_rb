FROM ruby

RUN mkdir /app

WORKDIR /app

COPY Gemfile* .

RUN bundle install
# TODO: only production

COPY . .

CMD bundle exec rake
