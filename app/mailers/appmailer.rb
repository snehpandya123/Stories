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

def invite(user)
  @user = user.all
  emails = @user.map {|user| user.email}

  
   mail(to: emails, subject: 'How to feel in Pandsoft')
 
end

end