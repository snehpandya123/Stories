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

def invite(u)
  @user = u
 mail(to: @user.email, subject: 'Create your life at pandsoft')
 
end
def invitep(u)
  @user = u
 mail(to: @user.email, subject: 'Add your Phase of life')
 
end
def invites(u)
  @user = u
 mail(to: @user.email, subject: 'Add your private story')
 
end

end