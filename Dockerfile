FROM ruby:2.5.1

RUN mkdir /myapp
WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
COPY .ruby-version /myapp/.ruby-version
RUN bundle install

COPY . /myapp

RUN chmod +x start.sh
ENTRYPOINT ["./start.sh"]

CMD rails s
