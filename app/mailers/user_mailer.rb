class UserMailer < ActionMailer::Base
  default from: ENV["AGENCYBOX_DEFAULT_FROM"]

  def new_leave(leave)
      @leave = leave
      mail(to: leave.user.email, subject: "You have applied a leave")
  end

  def new_expense(expense)
      @expense = expense
      mail(to: expense.user.email, subject: "You have applied for an expense claim")
  end

end
