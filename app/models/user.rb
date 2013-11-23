class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_many :project_members
  has_many :projects, through: :project_members, uniq: true
  has_many :leaves, class_name: LeaveApplication, foreign_key: :user_id
  has_many :expenses, class_name: Expense, foreign_key: :user_id

  attr_accessor :avatar
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" },
      :default_url => "/images/:style/missing.png"


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

    def total_leaves(year=nil)
        if not year
            year = Time.now.year
        end
        leaves = self.leaves.where("extract(year from created_at) = ?", year).pluck(:num_of_days)
        leaves.inject{|s,x| s+x}
    end

    def total_expenses(year=nil)
        if not year
            year = Time.now.year
        end
        expenses = self.expenses.where("extract(year from created_at) = ?", year).pluck(:amount)
        expenses.inject{ |s,x| s+x }
    end
end
