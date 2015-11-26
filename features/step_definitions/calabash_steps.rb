require 'calabash-android/calabash_steps'

Given(/^I enter my secret password into input fiend number (\d+)$/) do |arg1|
  enter_text("android.widget.EditText index:#{index.to_i-1}", "secret_password")
end
