rspec:
	bundle exec rspec

tests:
	rails test
	bundle exec rspec

server:
	rails s -b 0.0.0.0 -p 3000
