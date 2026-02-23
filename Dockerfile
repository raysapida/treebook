FROM ruby:2.7-alpine

RUN apk add --no-cache \
    build-base \
    postgresql-dev \
    nodejs \
    tzdata \
    ca-certificates \
    shared-mime-info \
    libxml2-dev \
    libxslt-dev \
    imagemagick

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Install Bundler 2.3.26
RUN gem install bundler -v 2.3.26
ENV BUNDLER_VERSION 2.3.26

# Force bundler to build nokogiri from source to avoid glibc/musl issues
RUN bundle config set --global force_ruby_platform true

# Disable Spring to avoid issues during upgrade
ENV DISABLE_SPRING 1

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .
RUN chmod +x bin/*

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
