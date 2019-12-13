FROM ruby:2.5
RUN mkdir -p /usr/src/tax/build
COPY Gemfile Gemfile.lock /usr/src/tax/build/
RUN cd /usr/src/tax/build && bundle install
WORKDIR /usr/src/tax
VOLUME [.]
CMD ["irb"]
