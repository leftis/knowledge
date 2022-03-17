FROM ruby:2.7.5

RUN mkdir /backend
WORKDIR /backend
COPY Gemfile /backend
COPY Gemfile.lock /backend
RUN bundle config --global frozen 1
RUN bundle install --without development test
COPY . /backend/
EXPOSE 50051
ENTRYPOINT [ "bundle", "exec"]
CMD ["application.rb"]