# ruby-base
FROM ruby:3.2.2-alpine AS ruby-base

RUN apk add \
  bash \
  build-base \
  postgresql-dev \
  postgresql-client \
  libxslt-dev \
  libxml2-dev \
  tzdata \
  nodejs

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
COPY ./Gemfile* ./
RUN bundle install


# production image
FROM ruby-base

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . .

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]