class PushSubscription < ActiveRecord::Base
  belongs_to :user
end

# == Schema Information
#
# Table name: push_subscription
#
#  id           :integer          not null, primary key
#  user_id      :integer          not null
#  data :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
