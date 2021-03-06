@application @message @log_level @time
Feature: Finding log entries that exactly match multiple fields
  As an Indy user I am able to create an instance and find all logs related to a particular application.

  Background:
   Given the following log:
    """
    2000-09-07 14:07:41 INFO  MyApp - Entering application.
    2000-09-07 14:07:42 DEBUG MyApp - Focusing application.
    2000-09-07 14:07:43 DEBUG MyApp - Blurring application.
    2000-09-07 14:07:44 WARN  MyApp - Low on Memory.
    2000-09-07 14:07:45 ERROR MyApp - Out of Memory.
    2000-09-07 14:07:46 INFO  MyApp - Exiting application.
    """
    
  Scenario: Count of entries that exactly match the application and log level
    When searching the log for:
      | application | severity |
      | MyApp       | DEBUG    |
    Then I expect to have found 2 log entries
    
    
  Scenario: Particular entry that exactly match a message and and a log level
    When searching the log for:
      | Message        | severity |
      | Out of Memory. | ERROR    |
    Then I expect to have found 1 log entry  
    And I expect the first entry to be:
    """
    2000-09-07 14:07:45 ERROR MyApp - Out of Memory.
    """


  Scenario: No entries for when looking at a matching time but not exact message
    When searching the log for:
      | time                | message               |
      | 2000-09-07 14:07:46 | Focusing application. |
    Then I expect to have found no log entries