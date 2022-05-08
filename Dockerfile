FROM ruby:3.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
  apt-get install -y nodejs
RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN gem update bundler && bundle install
COPY . /app

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["bundle", "exec", "rails", "server", "--binding", "0.0.0.0"]
