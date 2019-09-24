FROM ruby:2.6-alpine as builder


RUN apk add -U -u --purge alpine-sdk

RUN gem i bundler

RUN mkdir /app

WORKDIR /app

COPY .bundle-config ./.bundle/config

COPY Gemfile* ./

RUN bundle install --deployment --without development

COPY . ./

FROM ruby:2.6-alpine

RUN gem i bundler

# uncomment to enable CORS_HOST build-arg:
# ARG CORS_HOST
# ENV CORS_HOST $CORS_HOST

ARG JWT_TOKEN
ENV JWT_TOKEN $JWT_TOKEN

COPY --from=builder /app /app

WORKDIR /app

RUN bundle install --deployment --without development


CMD bundle exec rake
