require "development_mail_interceptor"

ActionMailer::Base.smtp_settings = {
   address: "smtp.gmail.com",
   port: 587,
   domain: "eznotes.ca",
   user_name: ENV["GMAIL_USERNAME"],
   password: ENV["GMAIL_PASSWORD"],
   authentication: "plain",
   enable_starttls_auto: false
}

ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?