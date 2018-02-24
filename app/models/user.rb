# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  name                   :string(255)
#  confirmed              :boolean
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :authentications, :dependent => :destroy
  has_many :children, dependent: :destroy
  has_many :messages, dependent: :destroy
  has_one :testimonial

  after_update :send_email, :if => :confirmed_changed?

  # def initialize
  #   self.confirmed = false
  # end
  # TODO

  def admin?
    self.email == "vinti.uiet@gmail.com" || self.email == "parryg@hotmail.com"
  end

  def confirmed?
    confirmed
  end

  def send_email
    if self.confirmed
      UserMailer.account_confirmation(self).deliver
    end
  end

  def self.holiday_reminder
    current_date = Time.now.strftime("%Y-%m-%d").to_s
    d = Date.parse(current_date) + 7

    if (d).holiday?(:us)
      holiday_name = Holidays.on(d, :us)[0][:name]
      @users = User.all
      @users.each do |u|
        UserMailer.remind_holiday(u, holiday_name, d).deliver if(u.confirmed?)
      end
    end
  end

  def self.feedback_request_reminder
    current_date = Date.parse(Time.now.strftime("%Y-%m-%d").to_s)
    Child.all.each do |c|
     if c.feedback_requested_date.nil?
       puts "inside nil feedback condition"
       @checking_date = c.joining_date + 2.months if c.joining_date
     else
       puts "inside else condition"
       @checking_date = c.feedback_requested_date + 2.months
     end
     puts "@checking_date: " + @checking_date.to_s
     puts "current_date: " + current_date.to_s

     if(@checking_date == current_date)
       puts "inside date meet condition"
       c.update_attributes(:feedback_requested_date => current_date)
       UserMailer.request_feedback(c.user_id).deliver
     end
    end
  end
end
