FROM ruby:2.3.7

# Fix apt sources for archived Debian Stretch
RUN echo "deb http://archive.debian.org/debian stretch main" > /etc/apt/sources.list && \
    echo "deb http://archive.debian.org/debian-security stretch/updates main" >> /etc/apt/sources.list && \
    apt-get update -o Acquire::Check-Valid-Until=false -qq && \
    apt-get install -y --force-yes build-essential libpq-dev nodejs ca-certificates

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Install a compatible version of Bundler
RUN gem install bundler -v 1.17.3

# ONLY copy Gemfile, ignore the old lockfile which has yanked gems
COPY Gemfile ./
RUN bundle install

COPY . .

EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
