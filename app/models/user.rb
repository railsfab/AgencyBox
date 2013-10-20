class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :project_members
  has_many :projects, through: :project_members


  include RoleModel

  roles :admin, :manager

  def available_name
      full_name = "#{self.first_name} #{self.last_name}"
      if full_name.strip.length > 0
          full_name
      else
          self.email.split("@")[0]
      end
  end
end
