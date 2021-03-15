xcodegen:
	xcodegen
	bundle exec pod install
setup:
	bundle install
	make xcodegen
update:
	bundle exec pod update