class ApplicationMailer < ActionMailer::Base
  	default from: "tjhagan88@gmail.com"
  	layout 'mailer'

  	before_filter :set_mailer_host   
	
	def set_mailer_host
	  
	  @url_host = 'localhost:3000'
	end
end
