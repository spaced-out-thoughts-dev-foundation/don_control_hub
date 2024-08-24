# Use an official Ruby runtime as a parent image
FROM ruby:3.0.0

# Set environment variables
ENV APP_HOME /app
ENV RACK_ENV production

# Set the working directory inside the container
WORKDIR $APP_HOME

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs

# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install the gems
RUN bundle install

# Copy the rest of the application code
COPY . .

# Expose port 4567 to the outside world
EXPOSE 4567

# The command to run the Sinatra app
CMD ["ruby", "app.rb"]
