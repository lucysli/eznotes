class DevelopmentMailInterceptor
   def self.delivering_email(message)
      message.subject = "[#{message.to}] #{message.subject}"
      message.to = "wisam.alabed@mail.mcgill.ca"
   end
end