class Appmailer < ActionMailer::Base
  default from: "teampandsoft@@gmail.com"
  def appriciation(user)
  	 @mail = user.email
  	
	 mail(:to => @mail, :subject => "Your Story is Appericiated" )
  end

  
 def comment(user)
  	 @mail = user.email
  	
	 mail(:to => @mail, :subject => "New Suggession on your Story" )
  end


end