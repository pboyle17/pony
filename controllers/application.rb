class ApplicationController < Sinatra::Base

  require 'bundler'
  require 'pony'
  require 'dotenv'
  Bundler.require
  Dotenv.load

  set :views, File.expand_path('../../views',__FILE__)

  get '/' do
    erb :home
  end

  post '/' do

    @message='thank you! your query has been posted'

    Pony.options = {
      :subject => "Some Subject",
      :body => "This is the body.",
      :via => :smtp,
      :via_options => {
        :address              => 'smtp.gmail.com',
        :port                 => '587',
        :enable_starttls_auto => true,
        :user_name            => 'pboyle17@gmail.com',
        :password             => ENV['EMAIL_PASS'],
        :authentication       => :plain, # :plain, :login, :cram_md5, no auth by default
        :domain               => "localhost.localdomain"
      }
    }

    Pony.mail(:to=>'pboyle17@gmail.com', :body=>params.to_s)
    erb :home
  end

end
