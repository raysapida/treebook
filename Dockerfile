FROM ruby:2.3.7

# Fix apt sources for archived Debian Stretch
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security stretch/updates main" >> /etc/apt/sources.list && \
    apt-get update -o Acquire::Check-Valid-Until=false -qq && \
    apt-get install -y --force-yes build-essential libpq-dev nodejs ca-certificates

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Install Bundler 2.3.26
RUN gem install bundler -v 2.3.26
# Force this version globally in the container
ENV BUNDLER_VERSION 2.3.26

# Disable Spring to avoid issues during upgrade
ENV DISABLE_SPRING 1

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .
RUN chmod +x bin/*

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
