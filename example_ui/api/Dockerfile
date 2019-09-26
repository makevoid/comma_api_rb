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

# uncomment to enable CORS_HOST build-arg:
# ARG CORS_HOST
# ENV CORS_HOST $CORS_HOST

# TODO: remove jwt token
# remove, insecure and less direct from a tier0 user (tier1 users are the ones that build the containers themselves basically :D)
# (this is why the docker image makevoid/comma_api_example_api is currently private, the jwt token is built/embedded into it - we should remove it for security, so that anyone can just pull the docker imgs, he/she/et.al... doesn't need to build it but atm having it in the image is convenient. # TODO: remove this message, this is way too long for a dockerfile
ARG JWT_TOKEN
ENV JWT_TOKEN $JWT_TOKEN

# we recommend SSDs on the box/VM you use to build this container, if your app becomes big this can take some time, the copy atm is not optimized if the repo is big, please make sure you add everything to your `.dockerignore` for optimizing this step, otherwise docker make no sense if you have a slow build

COPY --from=builder /app /app

WORKDIR /app

RUN bundle install --deployment --without development

# user rake to call `bundle exec rackup -p 3000` # port 3000 - note, if you edit this then change it also in API

CMD bundle exec rake
