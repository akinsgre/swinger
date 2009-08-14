module Swinger
  module TextField
    java_import org.netbeans.jemmy.operators.JTextFieldOperator
    java_import org.netbeans.jemmy.operators.JPasswordFieldOperator

    def text_field(id, container = @container)
      check_container("Text field") unless container
      JTextFieldOperator.new(container, string_or_numeric_id(id))
    end

    def password_field(id, container = @container)
      check_container("Password field") unless container
      JPasswordFieldOperator.new(container, string_or_numeric_id(id))
    end
  end
end

World(Swinger::TextField)

Given t(/^the text field "([^\"]*)" is filled with "([^\"]*)"$/) do |name, value|
  text_field(name).text.should == value
end

Given t(/^the text field "([^\"]*)" is (not )*enabled$/) do |name, negation|
  text_field(name).enabled?.send(negation ? :should_not : :should) == true
end

Then t(/^the text field "([^\"]*)" should (not )*be enabled$/) do |name, negation|
  text_field(name).enabled?.send(negation ? :should_not : :should) == true
end

Then t(/^the text field "([^\"]*)" should (not )*be empty$/) do |name, negation|
  text_field(name).text.empty?.should == !negation
end

Given t(/^the text field "([^\"]*)" is (not )*empty$/) do |name, negation|
  text_field(name).text.empty?.send(negation ? :should_not : :should) == true
end

When t(/^I fill the text field "([^\"]*)" with "([^\"]*)"$/) do |name, text|
  text_field(name).text = text
end

When t(/^I fill the password field "([^\"]*)" with "([^\"]*)"$/) do |name, text|
  password_field(name).text = text
end

Then t(/^the text field "([^\"]*)" should (be|contain) "([^\"]*)"$/) do |name, be, text|
  text_field(name).text.should include(text)
end