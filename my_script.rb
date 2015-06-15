require 'selenium-webdriver'

#registration
def register_as(login)
  @browser.find_element(:id, 'user_login').send_keys login
  @browser.find_element(:id, 'user_password').send_keys 'Qwerty123'
  @browser.find_element(:id, 'user_password_confirmation').send_keys 'Qwerty123'
  @browser.find_element(:id, 'user_firstname').send_keys 'Johny'
  @browser.find_element(:id, 'user_lastname').send_keys 'Gun'
  @browser.find_element(:id, 'user_mail').send_keys(login + '@1.ru')
  @browser.find_element(:name, 'commit').click
end

@browser = Selenium::WebDriver.for :firefox
@browser.get 'http://demo.redmine.org'
@browser.find_element(:class, 'register').click

login= 'Johny2'
register_as(login)

#logout/login
@browser.find_element(:class, 'logout').click
@browser.find_element(:class, 'login').click
sleep 1
@browser.find_element(:id, 'username').send_keys login
@browser.find_element(:id, 'password').send_keys 'Qwerty123'
@browser.find_element(:name, 'login').click

@browser.quit