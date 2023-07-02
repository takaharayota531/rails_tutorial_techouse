rspec:
	bundle exec rspec

tests:
	rails test
	bundle exec rspec
	rubocop -a

server:
	rails s -b 0.0.0.0 -p 3000
