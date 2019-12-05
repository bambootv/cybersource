FROM ruby:1.9

# Information about author
LABEL author.name="HoanKy" \
  author.email="hoanki2212@gmail.com"

# Install apt based dependencies required to run Rails as
# well as RubyGems. As the Ruby image itself is based on a
# Debian image, we use apt-get to install those.
RUN apt-get update && \
  apt-get install -y nano vim

# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
ENV APP_PATH /my_app
WORKDIR $APP_PATH

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile.lock $APP_PATH/
RUN bundle install --without production --retry 2 \
  --jobs `expr $(cat /proc/cpuinfo | grep -c "cpu cores") - 1`
RUN gem install bundler -v 1.1
RUN bundler update

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3001
