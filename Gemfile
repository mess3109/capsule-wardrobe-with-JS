source 'https://rubygems.org'

git_source(:github) do |repo_name|
	repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
	"https://github.com/#{repo_name}.git"
end

ruby '2.3.1'

gem 'rails', '~> 5.1.3'
#Add SQLite to  development mode only
gem 'pg', group: :production # Added postgres and made it production only.
gem 'rails_12factor'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'pry'
gem 'taps'
#for paperclip/amazon web services
gem 'aws-sdk', '~> 2'
# gem 'pg'

group :development, :test do
	gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
	gem 'capybara', '~> 2.13'
	gem 'selenium-webdriver'
	gem 'sqlite3'
end

group :development do
	gem 'web-console', '>= 3.3.0'
	gem 'listen', '>= 3.0.5', '< 3.2'
	gem 'spring'
	gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'devise'
gem 'omniauth-github'
gem 'dotenv-rails'
gem 'bootstrap-sass', "~> 3.1.1"
gem 'jquery-rails'
gem 'paperclip'
gem 'active_model_serializers'

