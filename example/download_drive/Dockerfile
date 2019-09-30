# run ruby program

# copy from example_ui_api/Dockerfile (basic ruby/alpine/bundler dockerfile)

# idea, bundle ffmpeg to do some video correction commands (brightness / contrast / sharpness_on=true)

# -------

# dockerfile:

# ruby-alpine-bundler-dockerfile

# this docker image is probably good as a base image

# basic ruby/alpine/bundler dockerfile

FROM ruby:2.6-alpine as builder

# we build a ruby container based on the alpine linux distro (light distro)

# we add a "heavvy step" here, which is fetching the alpine sdk, whici is totally unnecessary, but atm we are using puma which has a dep that needs to be built first
# if you remove the `puma` dependency

RUN apk add -U -u --purge alpine-sdk

RUN gem i bundler

RUN mkdir /app

WORKDIR /app

COPY .bundle-config ./.bundle/config

COPY Gemfile* ./

# we want to bundle an application for docker, we use the `--deployment` flag which will generate gem files in the vendor directory of the project

RUN bundle install --deployment --without development

COPY . ./

# this is the second layer of our docker conainer

FROM ruby:2.6-alpine

RUN gem i bundler

RUN mkdir -p /app/route

COPY --from=builder /app /app

WORKDIR /app

RUN bundle install --deployment --without development

# ENV ROUTE_ID
# ENV JWT_TOKEN

CMD bundle exec rake
