Feature: Login feature

  @reset
  Scenario: As a valid user I can log into my app
    Given I press the "Skype Name" button
    Given I enter "viet.ch2612" into input field number 1
    Given I enter my secret password into input fiend number 2
    When I press view with id "sign_in_btn"
    Then I should see "Add friend"
