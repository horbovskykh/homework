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

login= 'Johny'
register_as(login)
@browser.find_element(:class, 'logout').click
@browser.find_element(:class, 'register').click
login2= 'Johny2'
register_as(login2)

#logout/login
@browser.find_element(:class, 'logout').click
@browser.find_element(:class, 'login').click
sleep 1
@browser.find_element(:id, 'username').send_keys login
@browser.find_element(:id, 'password').send_keys 'Qwerty123'
@browser.find_element(:name, 'login').click

#change password
@browser.find_element(:class, 'my-account').click
@browser.find_element(:class, 'icon-passwd').click
sleep 1
@browser.find_element(:id, 'password').send_keys 'Qwerty123'
@browser.find_element(:id, 'new_password').send_keys 'Qwerty12345'
@browser.find_element(:id, 'new_password_confirmation').send_keys 'Qwerty12345'
@browser.find_element(:name, 'commit').click

#create project
project='apple'
@browser.find_element(:class, 'projects').click
@browser.find_element(:class, 'icon-add').click
sleep 1
@browser.find_element(:id, 'project_name').send_keys project
@browser.find_element(:id, 'project_description').send_keys 'entertaiment site'
@browser.find_element(:id, 'project_identifier').send_keys 'id'
@browser.find_element(:name, 'commit').click

#add member
@browser.find_element(:id, 'tab-members').click
@browser.find_element(:class, 'icon-add').click
sleep 2
@browser.find_element(:id, 'principal_search').send_keys 'john' #login
sleep 2
@browser.find_element(:xpath, ".//div[@id='principals']/label[contains(text()," + login +")]/input").attribute('value')
@browser.find_element(:xpath, ".//div[@id='principals']/label[contains(text()," + login +")]/input").click
@browser.find_element(:xpath, ".//label[.=' Manager']/input").click
@browser.find_element(id: 'member-add-submit').click

#change role
sleep 2
@browser.find_element(css: 'a.icon.icon-edit').click
@browser.find_element(:xpath, "(//input[@name='membership[role_ids][]'])[1]" ).click
@browser.find_element(:xpath, "(//input[@name='membership[role_ids][]'])[2]" ).click
@browser.find_element(:class, 'small').click

#project versions
#v1
sleep 2
@browser.find_element(:id, 'tab-versions').click
@browser.find_element(:css, '#tab-content-versions.tab-content .icon-add').click
@browser.find_element(:id, 'version_name').send_keys 'v1'
@browser.find_element(:xpath, ".//*[@id='version_status']/option[1]").click
@browser.find_element(:name, 'commit').click

#v2
@browser.find_element(:id, 'tab-versions').click
@browser.find_element(css: '#tab-content-versions.tab-content .icon-add').click
@browser.find_element(id:'version_name').send_keys 'v2'
@browser.find_element(:xpath, ".//*[@id='version_status']/option[1]").click
@browser.find_element(name:'commit').click

#v3
@browser.find_element(:id, 'tab-versions').click
@browser.find_element(css: '#tab-content-versions.tab-content .icon-add').click
@browser.find_element(id:'version_name').send_keys 'v3'
@browser.find_element(:xpath, ".//*[@id='version_status']/option[1]").click
@browser.find_element(name:'commit').click

#create issues
#bug issue
@browser.find_element(class:'new-issue').click
@browser.find_element(:xpath, ".//*[@id='issue_tracker_id']/option[1]").click
@browser.find_element(:id, 'issue_subject').send_keys 'Bug issue'
@browser.find_element(:id, 'issue_description').send_keys 'Bug issue'
@browser.find_element(name:'commit').click
issue_id_bug = @browser.find_element(css: "#flash_notice > a").attribute("href")[-5, 5]

#feature issue
@browser.find_element(class:'new-issue').click
@browser.find_element(:xpath, ".//*[@id='issue_tracker_id']/option[2]").click
@browser.find_element(:id, 'issue_subject').send_keys 'feature issue'
@browser.find_element(:id, 'issue_description').send_keys 'feture issue'
@browser.find_element(name:'commit').click
issue_id_feature = @browser.find_element(css: "#flash_notice > a").attribute("href")[-5, 5]

#support issue
@browser.find_element(class:'new-issue').click
@browser.find_element(:xpath, ".//*[@id='issue_tracker_id']/option[3]").click
@browser.find_element(:id, 'issue_subject').send_keys 'Support issue'
@browser.find_element(:id, 'issue_description').send_keys 'Support issue'
@browser.find_element(name:'commit').click
issue_id_support = @browser.find_element(css: "#flash_notice > a").attribute("href")[-5, 5]

sleep 2
@browser.find_element(:class, 'issues').click
sleep 2
fail 'Did not meet expected result' unless(@browser.find_element(link_text: issue_id_bug))&&(@browser.find_element(link_text: issue_id_feature))&&(@browser.find_element(link_text: issue_id_support)).displayed?
puts "All issues are visible"

@browser.quit