require_dependency 'webpush'

if SiteSetting.vapid_public_key.blank? || SiteSetting.vapid_private_key.blank?
  vapid_key = Webpush.generate_key
  SiteSetting.vapid_public_key = vapid_key.public_key
  SiteSetting.vapid_private_key = vapid_key.private_key
end

SiteSetting.vapid_public_key_bytes = Base64.urlsafe_decode64(SiteSetting.vapid_public_key).bytes.join("|")

DiscourseEvent.on(:post_notification_alert) do |user, payload|
  Jobs.enqueue(:send_push_notification, user_id: user.id, payload: payload)
end

DiscourseEvent.on(:user_logged_out) do |user|
  PushNotificationPusher.clear_subscriptions(user)
end
