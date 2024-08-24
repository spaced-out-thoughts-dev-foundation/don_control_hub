install:
	bundle install

run:
	make install && bundle exec ruby app.rb