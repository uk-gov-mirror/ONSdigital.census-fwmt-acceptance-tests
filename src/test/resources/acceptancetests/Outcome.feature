@Census @Acceptance @Outcome @SPG @CE
Feature: Outcome Tests

  Scenario Outline: As a Gateway I can receive an outcome from TM and create Census Events
    Given an "<SurveyType>" "<BusinessFunction>" outcome message
    And its Primary Outcome is "<Primary Outcome>"
    And its secondary Outcome "<Secondary Outcome>"
    And its Outcome code is "<Outcome Code>"
    And the message includes a Linked QID "<HasLinkedQID>"
    And the message includes a Fulfillment Request "<HasFulfilmentRequest>"
    When Gateway receives the outcome
    Then It will run the following processors "<Operation List>"
    And create the following messages to RM "<RmMessages>"
    And each message has the correct values
    And it will create the following messages "<JsMessages>" to JobService

    Examples:
      | SurveyType | BusinessFunction      | Primary Outcome | Secondary Outcome                       | Outcome Code | HasLinkedQID | HasFulfilmentRequest | Operation List                                                                 | RmMessages                                                 | JsMessages |
    | SPG        | Not Valid Address     | Not Valid       | Visit - Unoccupied Site                 | 6-30-03      | F            | F                    | ADDRESS_NOT_VALID,CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID              | ADDRESS_NOT_VALID                                            | CANCEL     |
    | SPG        | Not Valid Address     | Not Valid       | Visit - Unoccupied Site                 | 6-30-03      | T            | F                    | ADDRESS_NOT_VALID,CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID              | ADDRESS_NOT_VALID,QUESTIONNAIRE_LINKED                       | CANCEL     |
    | SPG        | Not Valid Address     | Not Valid       | Visit - Unoccupied Site                 | 6-30-03      | F            | T                    | ADDRESS_NOT_VALID,CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID              | ADDRESS_NOT_VALID,FULFILMENT_REQUESTED                       | CANCEL     |
    | SPG        | Not Valid Address     | Not Valid       | Visit - Unoccupied Site                 | 6-30-03      | T            | T                    | ADDRESS_NOT_VALID,CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID              | ADDRESS_NOT_VALID,QUESTIONNAIRE_LINKED,FULFILMENT_REQUESTED  | CANCEL     |

    | SPG        | Hard Refusal          | Contact Made    | Phone - Hard Refusal                    | 6-20-04      | F            | F                    | HARD_REFUSAL_RECEIVED,CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID          | REFUSAL_RECEIVED                                             | CANCEL     |
    | SPG        | Hard Refusal          | Contact Made    | Phone - Hard Refusal                    | 6-20-04      | T            | F                    | HARD_REFUSAL_RECEIVED,CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID          | REFUSAL_RECEIVED,QUESTIONNAIRE_LINKED                        | CANCEL     |
    | SPG        | Hard Refusal          | Contact Made    | Phone - Hard Refusal                    | 6-20-04      | F            | T                    | HARD_REFUSAL_RECEIVED,CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID          | REFUSAL_RECEIVED,FULFILMENT_REQUESTED                        | CANCEL     |
    | SPG        | Hard Refusal          | Contact Made    | Phone - Hard Refusal                    | 6-20-04      | T            | T                    | HARD_REFUSAL_RECEIVED,CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID          | REFUSAL_RECEIVED,QUESTIONNAIRE_LINKED,FULFILMENT_REQUESTED   | CANCEL     |

   | SPG        | Extraordinary Refusal | Contact Made    | Phone - Extraordinary Refusal           | 6-20-05      | F            | F                    | EXTRAORDINARY_REFUSAL_RECEIVED,CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID | REFUSAL_RECEIVED                                              | CANCEL     |
   | SPG        | Extraordinary Refusal | Contact Made    | Phone - Extraordinary Refusal           | 6-20-05      | T            | F                    | EXTRAORDINARY_REFUSAL_RECEIVED,CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID | REFUSAL_RECEIVED,QUESTIONNAIRE_LINKED                         | CANCEL     |
   | SPG        | Extraordinary Refusal | Contact Made    | Phone - Extraordinary Refusal           | 6-20-05      | F            | T                    | EXTRAORDINARY_REFUSAL_RECEIVED,CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID | REFUSAL_RECEIVED,FULFILMENT_REQUESTED                         | CANCEL     |
   | SPG        | Extraordinary Refusal | Contact Made    | Phone - Extraordinary Refusal           | 6-20-05      | T            | T                    | EXTRAORDINARY_REFUSAL_RECEIVED,CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID | REFUSAL_RECEIVED,QUESTIONNAIRE_LINKED,FULFILMENT_REQUESTED    | CANCEL     |

   | SPG        | Cancel Feedback       | Contact Made    | HICL or Paper H Questionnaire delivered | 22-20-05     | F            | F                    | CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID                                |                                                               | CANCEL     |
   | SPG        | Cancel Feedback       | Contact Made    | HICL or Paper H Questionnaire delivered | 22-20-05     | T            | F                    | CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID                                | QUESTIONNAIRE_LINKED                                          | CANCEL     |
   | SPG        | Cancel Feedback       | Contact Made    | HICL or Paper H Questionnaire delivered | 22-20-05     | F            | T                    | CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID                                | FULFILMENT_REQUESTED                                          | CANCEL     |
   | SPG        | Cancel Feedback       | Contact Made    | HICL or Paper H Questionnaire delivered | 22-20-05     | T            | T                    | CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID                                | QUESTIONNAIRE_LINKED,FULFILMENT_REQUESTED                     | CANCEL     |

   | SPG        | Delivered Feedback    | Contact Made    | HUAC required by text                   | 7-20-04      | F            | F                    | DELIVERED_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID                             |                                                               | UPDATE     |
   | SPG        | Delivered Feedback    | Contact Made    | HUAC required by text                   | 7-20-04      | T            | F                    | DELIVERED_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID                             | QUESTIONNAIRE_LINKED                                          | UPDATE     |
   | SPG        | Delivered Feedback    | Contact Made    | HUAC required by text                   | 7-20-04      | F            | T                    | DELIVERED_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID                             | FULFILMENT_REQUESTED                                          | UPDATE     |
   | SPG        | Delivered Feedback    | Contact Made    | HUAC required by text                   | 7-20-04      | T            | T                    | DELIVERED_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID                             | QUESTIONNAIRE_LINKED,FULFILMENT_REQUESTED                     | UPDATE     |


   | SPG        | No Action             | Irrelavant      | Irrelavant                              | 6-20-02      | F            | F                    | NO_ACTION,FULFILMENT_REQUESTED,LINKED_QID                                      |                                                               |            |
   | SPG        | No Action             | Irrelavant      | Irrelavant                              | 6-20-02      | T            | F                    | NO_ACTION,FULFILMENT_REQUESTED,LINKED_QID                                      | QUESTIONNAIRE_LINKED                                          |            |
   | SPG        | No Action             | Irrelavant      | Irrelavant                              | 6-20-02      | F            | T                    | NO_ACTION,FULFILMENT_REQUESTED,LINKED_QID                                      | FULFILMENT_REQUESTED                                          |            |
   | SPG        | No Action             | Irrelavant      | Irrelavant                              | 6-20-02      | T            | T                    | NO_ACTION,FULFILMENT_REQUESTED,LINKED_QID                                      | QUESTIONNAIRE_LINKED,FULFILMENT_REQUESTED                     |            |


   | CE         | Not Valid Address     | Not Valid       | Visit - Unoccupied Site                 | 20-10-05     | F            | F                    | ADDRESS_NOT_VALID,FULFILMENT_REQUESTED,LINKED_QID                              | ADDRESS_NOT_VALID                                             |            |
   | CE         | Not Valid Address     | Not Valid       | Visit - Unoccupied Site                 | 20-10-05     | T            | F                    | ADDRESS_NOT_VALID,FULFILMENT_REQUESTED,LINKED_QID                              | ADDRESS_NOT_VALID,QUESTIONNAIRE_LINKED                        |            |
   | CE         | Not Valid Address     | Not Valid       | Visit - Unoccupied Site                 | 20-10-05     | F            | T                    | ADDRESS_NOT_VALID,FULFILMENT_REQUESTED,LINKED_QID                              | ADDRESS_NOT_VALID,FULFILMENT_REQUESTED                        |            |
   | CE         | Not Valid Address     | Not Valid       | Visit - Unoccupied Site                 | 20-10-05     | T            | T                    | ADDRESS_NOT_VALID,FULFILMENT_REQUESTED,LINKED_QID                              | ADDRESS_NOT_VALID,QUESTIONNAIRE_LINKED,FULFILMENT_REQUESTED   |            |

   | CE         | Hard Refusal          | Contact Made    | Phone - Hard Refusal                    | 20-20-04     | F            | F                    | HARD_REFUSAL_RECEIVED,CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID          | REFUSAL_RECEIVED                                              | CANCEL     |
   | CE         | Hard Refusal          | Contact Made    | Phone - Hard Refusal                    | 20-20-04     | T            | F                    | HARD_REFUSAL_RECEIVED,CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID          | REFUSAL_RECEIVED,QUESTIONNAIRE_LINKED                         | CANCEL     |
   | CE         | Hard Refusal          | Contact Made    | Phone - Hard Refusal                    | 20-20-04     | F            | T                    | HARD_REFUSAL_RECEIVED,CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID          | REFUSAL_RECEIVED,FULFILMENT_REQUESTED                         | CANCEL     |
   | CE         | Hard Refusal          | Contact Made    | Phone - Hard Refusal                    | 20-20-04     | T            | T                    | HARD_REFUSAL_RECEIVED,CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID          | REFUSAL_RECEIVED,QUESTIONNAIRE_LINKED,FULFILMENT_REQUESTED    | CANCEL     |

   | CE         | Extraordinary Refusal | Contact Made    | Phone - Extraordinary Refusal           | 20-20-03     | F            | F                    | EXTRAORDINARY_REFUSAL_RECEIVED,CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID | REFUSAL_RECEIVED                                              | CANCEL     |
   | CE         | Extraordinary Refusal | Contact Made    | Phone - Extraordinary Refusal           | 20-20-03     | T            | F                    | EXTRAORDINARY_REFUSAL_RECEIVED,CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID | REFUSAL_RECEIVED,QUESTIONNAIRE_LINKED                         | CANCEL     |
   | CE         | Extraordinary Refusal | Contact Made    | Phone - Extraordinary Refusal           | 20-20-03     | F            | T                    | EXTRAORDINARY_REFUSAL_RECEIVED,CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID | REFUSAL_RECEIVED,FULFILMENT_REQUESTED                         | CANCEL     |
   | CE         | Extraordinary Refusal | Contact Made    | Phone - Extraordinary Refusal           | 20-20-03     | T            | T                    | EXTRAORDINARY_REFUSAL_RECEIVED,CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID | REFUSAL_RECEIVED,QUESTIONNAIRE_LINKED,FULFILMENT_REQUESTED    | CANCEL     |

   | CE         | Cancel Feedback       | Contact Made    | HICL or Paper H Questionnaire delivered | 22-20-05     | F            | F                    | CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID                                |                                                               | CANCEL     |
   | CE         | Cancel Feedback       | Contact Made    | HICL or Paper H Questionnaire delivered | 22-20-05     | T            | F                    | CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID                                | QUESTIONNAIRE_LINKED                                          | CANCEL     |
   | CE         | Cancel Feedback       | Contact Made    | HICL or Paper H Questionnaire delivered | 22-20-05     | F            | T                    | CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID                                | FULFILMENT_REQUESTED                                          | CANCEL     |
   | CE         | Cancel Feedback       | Contact Made    | HICL or Paper H Questionnaire delivered | 22-20-05     | T            | T                    | CANCEL_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID                                | QUESTIONNAIRE_LINKED,FULFILMENT_REQUESTED                     | CANCEL     |

   | CE         | Delivered Feedback    | Contact Made    | HUAC required by text                   | 7-20-04      | F            | F                    | DELIVERED_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID                             |                                                               | UPDATE     |
   | CE         | Delivered Feedback    | Contact Made    | HUAC required by text                   | 7-20-04      | T            | F                    | DELIVERED_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID                             | QUESTIONNAIRE_LINKED                                          | UPDATE     |
   | CE         | Delivered Feedback    | Contact Made    | HUAC required by text                   | 7-20-04      | F            | T                    | DELIVERED_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID                             | FULFILMENT_REQUESTED                                          | UPDATE     |
   | CE         | Delivered Feedback    | Contact Made    | HUAC required by text                   | 7-20-04      | T            | T                    | DELIVERED_FEEDBACK,FULFILMENT_REQUESTED,LINKED_QID                             | QUESTIONNAIRE_LINKED,FULFILMENT_REQUESTED                     | UPDATE     |

   | CE         | Update Resident Count | Contact Made    | Visit agreed to deliver                 | 20-20-01     | F            | F                    | UPDATE_RESIDENT_COUNT,FULFILMENT_REQUESTED,LINKED_QID                          | FIELD_CASE_UPDATED                                            |            |
   | CE         | Update Resident Count | Contact Made    | Visit agreed to deliver                 | 20-20-01     | T            | F                    | UPDATE_RESIDENT_COUNT,FULFILMENT_REQUESTED,LINKED_QID                          | FIELD_CASE_UPDATED,QUESTIONNAIRE_LINKED                       |            |
   | CE         | Update Resident Count | Contact Made    | Visit agreed to deliver                 | 20-20-01     | F            | T                    | UPDATE_RESIDENT_COUNT,FULFILMENT_REQUESTED,LINKED_QID                          | FIELD_CASE_UPDATED,FULFILMENT_REQUESTED                       |            |
   | CE         | Update Resident Count | Contact Made    | Visit agreed to deliver                 | 20-20-01     | T            | T                    | UPDATE_RESIDENT_COUNT,FULFILMENT_REQUESTED,LINKED_QID                          | FIELD_CASE_UPDATED,QUESTIONNAIRE_LINKED,FULFILMENT_REQUESTED  |            |

   | CE         | No Action             | Irrelavant      | Irrelavant                              | 25-30-02     | F            | F                    | NO_ACTION,FULFILMENT_REQUESTED,LINKED_QID                                      |                                                               |            |
   | CE         | No Action             | Irrelavant      | Irrelavant                              | 25-30-02     | T            | F                    | NO_ACTION,FULFILMENT_REQUESTED,LINKED_QID                                      | QUESTIONNAIRE_LINKED                                          |            |
   | CE         | No Action             | Irrelavant      | Irrelavant                              | 25-30-02     | F            | T                    | NO_ACTION,FULFILMENT_REQUESTED,LINKED_QID                                      | FULFILMENT_REQUESTED                                          |            |
   | CE         | No Action             | Irrelavant      | Irrelavant                              | 25-30-02     | T            | T                    | NO_ACTION,FULFILMENT_REQUESTED,LINKED_QID                                      | QUESTIONNAIRE_LINKED,FULFILMENT_REQUESTED                     |            |

   | HH         | Hard Refusal          | Contact Made    | Phone - Hard Refusal                    | 01-02-07     | F            | F                    | HARD_REFUSAL_RECEIVED                                                          | REFUSAL_RECEIVED                                              |            |
   | HH         | Extraordinary Refusal | Contact Made    | Phone - Extraordinary Refusal           | 01-02-08     | F            | F                    | EXTRAORDINARY_REFUSAL_RECEIVED                                                 | REFUSAL_RECEIVED                                              |            |

   | HH         | No Action             | Irrelavant      | Irrelavant                              | 01-01-04     | F            | F                    | NO_ACTION,LINKED_QID                                                           |                                                               |            |
   | HH         | No Action             | Irrelavant      | Irrelavant                              | 01-01-04     | T            | F                    | NO_ACTION,LINKED_QID                                                           | QUESTIONNAIRE_LINKED                                          |            |

      | HH         | No Action                | Irrelevant      | Irrelevant                              | 01-01-05     | F            | F                    | NO_ACTION,FULFILMENT_REQUESTED                                                 |                                                              |               |
      | HH         | No Action                | Irrelevant      | Irrelevant                              | 01-01-05     | F            | T                    | NO_ACTION,FULFILMENT_REQUESTED                                                 | FULFILMENT_REQUESTED                                         |               |

      | HH         | Not Valid Address        | Contact Made    | Visit - Unoccupied Site                 | 01-02-06     | F            | F                    | ADDRESS_NOT_VALID                                                              | ADDRESS_NOT_VALID                                            |               |














      | CCS        | Interview Required       | Contact Made    | Interview Required                      | 30-01-01     | F            | F                    | PROPERTY_LISTED                                                                | PROPERTY_LISTED                                              |               |

      | CCS        | Property Listed          | Contact Made    | Property Listed                         | 30-01-02     | F            | F                    | PROPERTY_LISTED,LINKED_QID                                                     | PROPERTY_LISTED                                              |               |
      | CCS        | Property Listed          | Contact Made    | Property Listed                         | 30-01-02     | T            | F                    | PROPERTY_LISTED,LINKED_QID                                                     | PROPERTY_LISTED,LINKED_QID                                   |               |

      | CCS        | Property Listed          | Contact Made    | Property Listed                         | 30-01-03     | T            | F                    | PROPERTY_LISTED,LINKED_QID                                                     | PROPERTY_LISTED,LINKED_QID                                   |               |
      | CCS        | Property Listed          | Contact Made    | Property Listed                         | 30-01-03     | F            | F                    | PROPERTY_LISTED,LINKED_QID                                                     | PROPERTY_LISTED                                              |               |

      | CCS        | Property Listed          | Contact Made    | Hard Refusal                            | 30-01-04     | F            | F                    | PROPERTY_LISTED,HARD_REFUSAL_RECEIVED                                          | PROPERTY_LISTED,HARD_REFUSAL_RECEIVED                        |               |


      | CCS        | Property Listed          | Contact Made    | Extraordinary Refusal                   | 30-01-05     | F            | F                    | PROPERTY_LISTED,EXTRAORDINARY_REFUSAL_RECEIVED                                 | PROPERTY_LISTED,EXTRAORDINARY_REFUSAL_RECEIVED               |               |


      | CCS        | Property Listed          | Contact Made    | Unoccupied Site                         | 30-01-06     | F            | F                    | PROPERTY_LISTED,ADDRESS_NOT_VALID                                              | PROPERTY_LISTED,ADDRESS_NOT_VALID                            |               |

      | CCS        | Property Listed          | Contact Made    | Unoccupied Site                         | 30-01-07     | F            | F                    | PROPERTY_LISTED,ADDRESS_NOT_VALID                                              | PROPERTY_LISTED,ADDRESS_NOT_VALID                            |               |

      | CCS        | Interview Required       | Contact Made    | Interview Required                      | 30-02-01     | F            | F                    | PROPERTY_LISTED                                                                | PROPERTY_LISTED                                              |               |

      | CCS        | Property Listed          | Contact Made    | Property Listed                         | 30-02-02     | F            | F                    | PROPERTY_LISTED                                                                | PROPERTY_LISTED                                              |               |

      | CCS        | Property Listed          | Contact Made    | Property Listed                         | 30-02-03     | F            | F                    | PROPERTY_LISTED,LINKED_QID                                                     | PROPERTY_LISTED                                              |               |
      | CCS        | Property Listed          | Contact Made    | Property Listed                         | 30-02-03     | T            | F                    | PROPERTY_LISTED,LINKED_QID                                                     | PROPERTY_LISTED,LINKED_QID                                   |               |

      | CCS        | Interview Required       | Contact Made    | Interview Required                      | 30-02-04     | F            | F                    | PROPERTY_LISTED,LINKED_QID                                                     | PROPERTY_LISTED                                              |               |
      | CCS        | Interview Required       | Contact Made    | Interview Required                      | 30-02-04     | T            | F                    | PROPERTY_LISTED,LINKED_QID                                                     | PROPERTY_LISTED,LINKED_QID                                   |               |

      | CCS        | Property Listed          | Contact Made    | Hard Refusal                            | 30-02-05     | F            | F                    | PROPERTY_LISTED,HARD_REFUSAL_RECEIVED                                          | PROPERTY_LISTED,HARD_REFUSAL_RECEIVED                        |               |

      | CCS        | Property Listed          | Contact Made    | Extraordinary Refusal                   | 30-02-06     | F            | F                    | PROPERTY_LISTED,EXTRAORDINARY_REFUSAL_RECEIVED                                 | PROPERTY_LISTED,EXTRAORDINARY_REFUSAL_RECEIVED               |               |


      | CCS        | Property Listed          | Contact Made    | Unoccupied Site                         | 30-02-07     | F            | F                    | PROPERTY_LISTED,ADDRESS_NOT_VALID                                              | PROPERTY_LISTED,ADDRESS_NOT_VALID                            |               |

      | CCS        | Property Listed          | Contact Made    | Unoccupied Site                         | 30-01-08     | F            | F                    | PROPERTY_LISTED,ADDRESS_NOT_VALID                                              | PROPERTY_LISTED,ADDRESS_NOT_VALID                            |               |

      | CCS        | Property Listed          | Contact Made    | Unoccupied Site                         | 30-02-01     | F            | F                    | PROPERTY_LISTED,ADDRESS_NOT_VALID                                              | PROPERTY_LISTED,ADDRESS_NOT_VALID                            |               |

      | CCS        | No Action                | Irrelevant      | Irrelevant                              | 30-01-01     | F            | F                    | NO_ACTION                                                                      | NO_ACTION                                                    |               |

      | CCS        | Cancel Feedback          | Cancel Feedback | Cancel Feedback                         | 30-01-02     | F            | F                    | CANCEL_FEEDBACK                                                                |                                                              | CANCEL        |










      | CCS        | No Action                | Irrelevant      | Irrelevant                              | 31-01-01     | F            | F                    | NO_ACTION                                                                      | NO_ACTION                                                    |               |
      | CCS        | Cancel Feedback          | Cancel Feedback | Cancel Feedback                         | 31-01-02     | F            | F                    | CANCEL_FEEDBACK                                                                |                                                              | CANCEL        |
      | CCS        | No Action                | Irrelevant      | Irrelevant                              | 31-01-03     | F            | F                    | NO_ACTION                                                                      | NO_ACTION                                                    |               |
      | CCS        | Cancel Feedback          | Cancel Feedback | Cancel Feedback                         | 31-01-04     | F            | F                    | CANCEL_FEEDBACK                                                                |                                                              | CANCEL        |

      | CCS        | Cancel Feedback          | Cancel Feedback | Cancel Feedback                         | 31-01-05     | F            | F                    | CANCEL_FEEDBACK,LINKED_QID                                                     | LINKED_QID                                                   | CANCEL        |
      | CCS        | Cancel Feedback          | Cancel Feedback | Cancel Feedback                         | 31-01-05     | T            | F                    | CANCEL_FEEDBACK,LINKED_QID                                                     | LINKED_QID,LINKED_QID                                        | CANCEL        |

      | CCS        | Cancel Feedback          | Cancel Feedback | Cancel Feedback                         | 31-02-01     | F            | F                    | CANCEL_FEEDBACK                                                                |                                                              | CANCEL        |

      | CCS        | No Action                | Irrelevant      | Irrelevant                              | 31-02-02     | F            | F                    | NO_ACTION                                                                      | NO_ACTION                                                    |               |

      | CCS        | Cancel Feedback          | Cancel Feedback | Cancel Feedback                         | 31-02-03     | F            | F                    | CANCEL_FEEDBACK,LINKED_QID                                                     | LINKED_QID                                                   | CANCEL        |
      | CCS        | Cancel Feedback          | Cancel Feedback | Cancel Feedback                         | 31-02-03     | T            | F                    | CANCEL_FEEDBACK,LINKED_QID                                                     | LINKED_QID,LINKED_QID                                        | CANCEL        |

      | CCS        | Property Listed          | Contact Made    | Property Listed                         | 31-02-04     | T            | F                    | LINKED_QID                                                                     | LINKED_QID                                                   |               |
      | CCS        | Property Listed          | Contact Made    | Property Listed                         | 31-02-04     | F            | F                    | LINKED_QID                                                                     |                                                              |               |

      | CCS        | No Action                | Irrelevant      | Irrelevant                              | 31-02-05     | F            | F                    | NO_ACTION                                                                      | NO_ACTION                                                    |               |
      | CCS        | No Action                | Irrelevant      | Irrelevant                              | 31-02-06     | F            | F                    | NO_ACTION                                                                      | NO_ACTION                                                    |               |

      | CCS        | Property Listed          | Contact Made    | Extraordinary Refusal                   | 31-02-07     | F            | F                    | EXTRAORDINARY_REFUSAL_RECEIVED                                                 | EXTRAORDINARY_REFUSAL_RECEIVED,CANCEL_FEEDBACK               | CANCEL        |
      | CCS        | Property Listed          | Contact Made    | Hard Refusal                            | 31-02-08     | F            | F                    | HARD_REFUSAL_RECEIVED                                                          | HARD_REFUSAL_RECEIVED,CANCEL_FEEDBACK                        | CANCEL        |

      | CCS        | Property Listed          | Contact Made    | Unoccupied Site                         | 31-03-01     | F            | F                    | ADDRESS_NOT_VALID                                                              | ADDRESS_NOT_VALID                                            |               |
      | CCS        | Property Listed          | Contact Made    | Unoccupied Site                         | 31-03-02     | F            | F                    | ADDRESS_NOT_VALID                                                              | ADDRESS_NOT_VALID                                            |               |
      | CCS        | Property Listed          | Contact Made    | Unoccupied Site                         | 31-03-03     | F            | F                    | ADDRESS_NOT_VALID                                                              | ADDRESS_NOT_VALID                                            |               |
      | CCS        | Property Listed          | Contact Made    | Unoccupied Site                         | 31-03-04     | F            | F                    | ADDRESS_NOT_VALID                                                              | ADDRESS_NOT_VALID                                            |               |


      | CCS        | No Action                | Irrelevant      | Irrelevant                              | 32-01-01     | F            | F                    | NO_ACTION                                                                      | NO_ACTION                                                    |               |
      | CCS        | No Action                | Irrelevant      | Irrelevant                              | 32-01-02     | F            | F                    | NO_ACTION                                                                      | NO_ACTION                                                    |               |

      | CCS        | Cancel Feedback          | Cancel Feedback | Cancel Feedback                         | 32-01-03     | F            | F                    | CANCEL_FEEDBACK                                                                |                                                              | CANCEL        |
      | CCS        | Cancel Feedback          | Cancel Feedback | Cancel Feedback                         | 32-01-04     | F            | F                    | CANCEL_FEEDBACK                                                                |                                                              | CANCEL        |

      | CCS        | Cancel Feedback          | Cancel Feedback | Cancel Feedback                         | 32-02-01     | T            | F                    | CANCEL_FEEDBACK,LINKED_QID                                                     | LINKED_QID                                                   | CANCEL        |
      | CCS        | Cancel Feedback          | Cancel Feedback | Cancel Feedback                         | 32-02-01     | F            | F                    | CANCEL_FEEDBACK,LINKED_QID                                                     |                                                              | CANCEL        |

      | CCS        | Property Listed          | Contact Made    | Linked Questionnaire                    | 32-02-02     | T            | F                    | LINKED_QID                                                                     | LINKED_QID                                                   |               |
      | CCS        | Property Listed          | Contact Made    | Linked Questionnaire                    | 32-02-02     | F            | F                    | LINKED_QID                                                                     |                                                              |               |

      | CCS        | No Action                | Irrelevant      | Irrelevant                              | 32-02-03     | F            | F                    | NO_ACTION                                                                      | NO_ACTION                                                    |               |
      | CCS        | No Action - confirm code | Irrelevant      | Irrelevant                              | 32-02-06     | F            | F                    | NO_ACTION                                                                      | NO_ACTION                                                    |               |

      | CCS        | Property Listed          | Contact Made    | Extraordinary Refusal                   | 31-02-04     | F            | F                    | EXTRAORDINARY_REFUSAL_RECEIVED,CANCEL_FEEDBACK                                 | EXTRAORDINARY_REFUSAL_RECEIVED,CANCEL_FEEDBACK               | CANCEL        |
      | CCS        | Property Listed          | Contact Made    | Hard Refusal                            | 31-02-05     | F            | F                    | HARD_REFUSAL_RECEIVED,CANCEL_FEEDBACK                                          | HARD_REFUSAL_RECEIVED,CANCEL_FEEDBACK                        | CANCEL        |

      | CCS        | Property Listed          | Contact Made    | Unoccupied Site                         | 32-03-01     | F            | F                    | ADDRESS_NOT_VALID                                                              | ADDRESS_NOT_VALID                                            |               |
      | CCS        | Property Listed          | Contact Made    | Unoccupied Site                         | 32-03-02     | F            | F                    | ADDRESS_NOT_VALID                                                              | ADDRESS_NOT_VALID                                            |               |
      | CCS        | Property Listed          | Contact Made    | Unoccupied Site                         | 32-03-03     | F            | F                    | ADDRESS_NOT_VALID                                                              | ADDRESS_NOT_VALID                                            |               |
      | CCS        | Property Listed          | Contact Made    | Unoccupied Site                         | 32-03-04     | F            | F                    | ADDRESS_NOT_VALID                                                              | ADDRESS_NOT_VALID                                            |               |
      | CCS        | Property Listed          | Contact Made    | Unoccupied Site                         | 32-03-05     | F            | F                    | ADDRESS_NOT_VALID                                                              | ADDRESS_NOT_VALID                                            |               |


  30-01-01|INTERVIEW_REQUIRED_HH
  30-01-02|PROPERTY_LISTED_HH,LINKED_QID
  30-01-03|INTERVIEW_REQUIRED_HH,LINKED_QID
  30-01-04|PROPERTY_LISTED_HH,HARD_REFUSAL_RECEIVE
  30-01-05|PROPERTY_LISTED_HH,EXTRAORDINARY_REFUSAL_RECEIVED
  30-01-06|PROPERTY_LISTED_HH,ADDRESS_NOT_VALID
  30-01-07|PROPERTY_LISTED_HH,ADDRESS_NOT_VALID
  30-02-01|INTERVIEW_REQUIRED_CE
  30-02-02|PROPERTY_LISTED_CE
  30-02-03|PROPERTY_LISTED_CE,LINKED_QID
  30-02-04|INTERVIEW_REQUIRED_CE,LINKED_QI
  30-02-05|PROPERTY_LISTED_CE,HARD_REFUSAL_RECEIVED
  30-02-06|PROPERTY_LISTED_CE,EXTRAORDINARY_REFUSAL_RECEIVED
  30-02-07|PROPERTY_LISTED_CE,ADDRESS_NOT_VALID
  30-02-08|PROPERTY_LISTED_CE,ADDRESS_NOT_VALID
  30-03-01|PROPERTY_LISTED_CE,ADDRESS_NOT_VALID
