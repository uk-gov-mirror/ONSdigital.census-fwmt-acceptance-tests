@Census @Acceptance @Outcome @SPG @CE
Feature: Outcome New Address Reported Tests

  Scenario Outline: As a Gateway I can receive an outcome from TM and create Census Events
    Given an "<SurveyType>" "<BusinessFunction>" outcome message
    And its Primary Outcome is "<Primary Outcome>"
    And its secondary Outcome "<Secondary Outcome>"
    And its Outcome code is "<Outcome Code>"
    And the message includes Usual Residents Count "<HasUsualResidents>"
    And the message includes a Linked QID "<HasLinkedQID>"
    And the message includes a Fulfillment Request "<HasFulfilmentRequest>"
    When Gateway receives the outcome
    Then It will run the following processors "<Operation List>"
    And create the following messages to RM "<RmMessages>"
    And the caseId of the "<InitialOperation>" message will be a new caseId
    And every other message will use the new caseId as its caseId
    And each message has the correct values
    And it will create the following messages "<JsMessages>" to JobService

   Examples:
   | SurveyType | BusinessFunction         | Primary Outcome               | Secondary Outcome                | Outcome Code | HasUsualResidents | HasLinkedQID | HasFulfilmentRequest | Operation List                                                              | RmMessages                                                                      | InitialOperation      | JsMessages        |

   | SPG        | New Unit Reported        | Contact Made                  | Visit another time               | 9-20-01      | F                 | F            | F                    | NEW_UNIT_ADDRESS,FULFILMENT_REQUESTED,LINKED_QID                            | NEW_ADDRESS_REPORTED                                                            | NEW_ADDRESS_REPORTED  |                   |
   | SPG        | New Unit Reported        | Contact Made                  | Visit another time               | 9-20-01      | F                 | T            | F                    | NEW_UNIT_ADDRESS,FULFILMENT_REQUESTED,LINKED_QID                            | NEW_ADDRESS_REPORTED,QUESTIONNAIRE_LINKED                                       | NEW_ADDRESS_REPORTED  |                   |
   | SPG        | New Unit Reported        | Contact Made                  | Visit another time               | 9-20-01      | F                 | F            | T                    | NEW_UNIT_ADDRESS,FULFILMENT_REQUESTED,LINKED_QID                            | NEW_ADDRESS_REPORTED,FULFILMENT_REQUESTED                                       | NEW_ADDRESS_REPORTED  |                   |
   | SPG        | New Unit Reported        | Contact Made                  | Visit another time               | 9-20-01      | F                 | T            | T                    | NEW_UNIT_ADDRESS,FULFILMENT_REQUESTED,LINKED_QID                            | NEW_ADDRESS_REPORTED,QUESTIONNAIRE_LINKED,FULFILMENT_REQUESTED                  | NEW_ADDRESS_REPORTED  |                   |

   | CE         | New Unit Reported        | Contact Made                  | Visit another time               | 23-20-01     | F                 | F            | F                    | SWITCH_FEEDBACK_CE_SITE,NEW_UNIT_ADDRESS,FULFILMENT_REQUESTED,LINKED_QID    | NEW_ADDRESS_REPORTED                                                            | NEW_ADDRESS_REPORTED  | SWITCH_CE_TYPE    |
   | CE         | New Unit Reported        | Contact Made                  | Visit another time               | 23-20-01     | F                 | T            | F                    | SWITCH_FEEDBACK_CE_SITE,NEW_UNIT_ADDRESS,FULFILMENT_REQUESTED,LINKED_QID    | NEW_ADDRESS_REPORTED,QUESTIONNAIRE_LINKED                                       | NEW_ADDRESS_REPORTED  | SWITCH_CE_TYPE    |
   | CE         | New Unit Reported        | Contact Made                  | Visit another time               | 23-20-01     | F                 | F            | T                    | SWITCH_FEEDBACK_CE_SITE,NEW_UNIT_ADDRESS,FULFILMENT_REQUESTED,LINKED_QID    | NEW_ADDRESS_REPORTED,FULFILMENT_REQUESTED                                       | NEW_ADDRESS_REPORTED  | SWITCH_CE_TYPE    |
   | CE         | New Unit Reported        | Contact Made                  | Visit another time               | 23-20-01     | F                 | T            | T                    | SWITCH_FEEDBACK_CE_SITE,NEW_UNIT_ADDRESS,FULFILMENT_REQUESTED,LINKED_QID    | NEW_ADDRESS_REPORTED,QUESTIONNAIRE_LINKED,FULFILMENT_REQUESTED                  | NEW_ADDRESS_REPORTED  | SWITCH_CE_TYPE    |
   | CE         | New Unit Reported        | Contact Made                  | Visit another time               | 23-20-01     | T                 | F            | F                    | SWITCH_FEEDBACK_CE_SITE,NEW_UNIT_ADDRESS,FULFILMENT_REQUESTED,LINKED_QID    | NEW_ADDRESS_REPORTED                                                            | NEW_ADDRESS_REPORTED  | SWITCH_CE_TYPE    |
   | CE         | New Unit Reported        | Contact Made                  | Visit another time               | 23-20-01     | T                 | T            | F                    | SWITCH_FEEDBACK_CE_SITE,NEW_UNIT_ADDRESS,FULFILMENT_REQUESTED,LINKED_QID    | NEW_ADDRESS_REPORTED,QUESTIONNAIRE_LINKED                                       | NEW_ADDRESS_REPORTED  | SWITCH_CE_TYPE    |
   | CE         | New Unit Reported        | Contact Made                  | Visit another time               | 23-20-01     | T                 | F            | T                    | SWITCH_FEEDBACK_CE_SITE,NEW_UNIT_ADDRESS,FULFILMENT_REQUESTED,LINKED_QID    | NEW_ADDRESS_REPORTED,FULFILMENT_REQUESTED                                       | NEW_ADDRESS_REPORTED  | SWITCH_CE_TYPE    |
   | CE         | New Unit Reported        | Contact Made                  | Visit another time               | 23-20-01     | T                 | T            | T                    | SWITCH_FEEDBACK_CE_SITE,NEW_UNIT_ADDRESS,FULFILMENT_REQUESTED,LINKED_QID    | NEW_ADDRESS_REPORTED,QUESTIONNAIRE_LINKED,FULFILMENT_REQUESTED                  | NEW_ADDRESS_REPORTED  | SWITCH_CE_TYPE    |

   | SPG        | New Standalone Address   | Access Granted - Contact Made | HUAC required by text            | 10-20-04     | F                 | F            | F                    | NEW_ADDRESS_REPORTED,FULFILMENT_REQUESTED,LINKED_QID                        | NEW_ADDRESS_REPORTED                                                            | NEW_ADDRESS_REPORTED  |                   |
   | SPG        | New Standalone Address   | Access Granted - Contact Made | HUAC required by text            | 10-20-04     | F                 | T            | F                    | NEW_ADDRESS_REPORTED,FULFILMENT_REQUESTED,LINKED_QID                        | NEW_ADDRESS_REPORTED,QUESTIONNAIRE_LINKED                                       | NEW_ADDRESS_REPORTED  |                   |
   | SPG        | New Standalone Address   | Access Granted - Contact Made | HUAC required by text            | 10-20-04     | F                 | F            | T                    | NEW_ADDRESS_REPORTED,FULFILMENT_REQUESTED,LINKED_QID                        | NEW_ADDRESS_REPORTED,FULFILMENT_REQUESTED                                       | NEW_ADDRESS_REPORTED  |                   |
   | SPG        | New Standalone Address   | Access Granted - Contact Made | HUAC required by text            | 10-20-04     | F                 | T            | T                    | NEW_ADDRESS_REPORTED,FULFILMENT_REQUESTED,LINKED_QID                        | NEW_ADDRESS_REPORTED,QUESTIONNAIRE_LINKED,FULFILMENT_REQUESTED                  | NEW_ADDRESS_REPORTED  |                   |

   | CE         | New Standalone Address   | Access Granted - Contact Made | HUAC required by text            | 26-20-01     | F                 | F            | F                    | NEW_ADDRESS_REPORTED,HARD_REFUSAL_RECEIVED,FULFILMENT_REQUESTED,LINKED_QID  | NEW_ADDRESS_REPORTED,REFUSAL_RECEIVED                                           | NEW_ADDRESS_REPORTED  |                   |
   | CE         | New Standalone Address   | Access Granted - Contact Made | HUAC required by text            | 26-20-01     | F                 | T            | F                    | NEW_ADDRESS_REPORTED,HARD_REFUSAL_RECEIVED,FULFILMENT_REQUESTED,LINKED_QID  | NEW_ADDRESS_REPORTED,REFUSAL_RECEIVED,QUESTIONNAIRE_LINKED                      | NEW_ADDRESS_REPORTED  |                   |
   | CE         | New Standalone Address   | Access Granted - Contact Made | HUAC required by text            | 26-20-01     | F                 | F            | T                    | NEW_ADDRESS_REPORTED,HARD_REFUSAL_RECEIVED,FULFILMENT_REQUESTED,LINKED_QID  | NEW_ADDRESS_REPORTED,REFUSAL_RECEIVED,FULFILMENT_REQUESTED                      | NEW_ADDRESS_REPORTED  |                   |
   | CE         | New Standalone Address   | Access Granted - Contact Made | HUAC required by text            | 26-20-01     | F                 | T            | T                    | NEW_ADDRESS_REPORTED,HARD_REFUSAL_RECEIVED,FULFILMENT_REQUESTED,LINKED_QID  | NEW_ADDRESS_REPORTED,REFUSAL_RECEIVED,QUESTIONNAIRE_LINKED,FULFILMENT_REQUESTED | NEW_ADDRESS_REPORTED  |                   |
   | CE         | New Standalone Address   | Access Granted - Contact Made | HUAC required by text            | 26-20-01     | T                 | F            | F                    | NEW_ADDRESS_REPORTED,HARD_REFUSAL_RECEIVED,FULFILMENT_REQUESTED,LINKED_QID  | NEW_ADDRESS_REPORTED,REFUSAL_RECEIVED                                           | NEW_ADDRESS_REPORTED  |                   |
   | CE         | New Standalone Address   | Access Granted - Contact Made | HUAC required by text            | 26-20-01     | T                 | T            | F                    | NEW_ADDRESS_REPORTED,HARD_REFUSAL_RECEIVED,FULFILMENT_REQUESTED,LINKED_QID  | NEW_ADDRESS_REPORTED,REFUSAL_RECEIVED,QUESTIONNAIRE_LINKED                      | NEW_ADDRESS_REPORTED  |                   |
   | CE         | New Standalone Address   | Access Granted - Contact Made | HUAC required by text            | 26-20-01     | T                 | F            | T                    | NEW_ADDRESS_REPORTED,HARD_REFUSAL_RECEIVED,FULFILMENT_REQUESTED,LINKED_QID  | NEW_ADDRESS_REPORTED,REFUSAL_RECEIVED,FULFILMENT_REQUESTED                      | NEW_ADDRESS_REPORTED  |                   |
   | CE         | New Standalone Address   | Access Granted - Contact Made | HUAC required by text            | 26-20-01     | T                 | T            | T                    | NEW_ADDRESS_REPORTED,HARD_REFUSAL_RECEIVED,FULFILMENT_REQUESTED,LINKED_QID  | NEW_ADDRESS_REPORTED,REFUSAL_RECEIVED,QUESTIONNAIRE_LINKED,FULFILMENT_REQUESTED | NEW_ADDRESS_REPORTED  |                   |
