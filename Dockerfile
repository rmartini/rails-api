FROM ruby:2.5-slim
MAINTAINER Richard Martini <martini.richard@gmail.com>
RUN mkdir -p /usr/share/man/man1 && apt-get update && \
    apt-get install -qq -y software-properties-common build-essential \
    patch ruby-dev zlib1g-dev liblzma-dev nodejs libpq-dev openjdk-8-jre \
    vim tzdata --fix-missing --no-install-recommends && \
    ln -s /usr/bin/nodejs /usr/bin/node && \
    apt-get clean autoclean && apt-get -y autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/*
ENV RAILS_ENV='development' \
    RAKE_ENV='development' \
    APP_HOME='/home/app'
WORKDIR $APP_HOME
COPY Gemfile Gemfile.lock ./
RUN gem install bundler --no-document && \
    echo "gem: --no-document" > ~/.gemrc && \
    bundle install --binstubs
COPY . ./
EXPOSE 4000
CMD puma -C config/puma.rb
