class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  def available_name
      full_name = "#{self.first_name} #{self.last_name}"
      if full_name.strip.length > 0
          full_name
      else
          self.email.split("@")[0]
      end
  end
end
