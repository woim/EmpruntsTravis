Feature: Je veux pouvoir selectionner les emprunts selon divers criteres

  @avec_depot_emprunts_txt
  Scenario: Je selectionne les emprunts faits par une personne qui n'a aucun emprunt
  
    When je selectionne les emprunts faits par "Charles"

    Then 0 document a ete selectionne


  @avec_depot_emprunts_txt
  Scenario: Je selectionne les emprunts faits par une personne qui a des emprunts
  
    When je selectionne les emprunts faits par "Guy"

    Then 2 documents ont ete selectionnes
    And le titre du document 0 est "Code Complete"
    And le titre du document 1 est "Pragmatic Programmer"


  @avec_depot_emprunts_txt
  Scenario: Je selectionne les emprunts ayant un titre contenant un mot
  
    When je selectionne les emprunts dont le titre matche "Code"

    Then 1 document a ete selectionne
    And le titre du document 0 est "Code Complete"


  @avec_depot_emprunts_txt
  Scenario: Je selectionne l'emprunt ayant un titre specifique
  
    When je selectionne l'unique emprunt dont le titre est "Code Complete"

    Then le titre de l'unique document selectionne est "Code Complete"


  @avec_depot_emprunts_txt
  Scenario: Je selectionne un document a partir d'un mot du titre mais avec
            actions/postconditions generiques

    When je selectionne les emprunts tels que le "titre" matche "Code"

    Then 1 document a ete selectionne
    And le "titre" du document 0 est "Code Complete"


  @avec_depot_emprunts_txt
  Scenario: Je selectionne un document a partir d'un nom mais avec
            actions/postconditions generiques

    When je selectionne les emprunts tels que le "nom" matche "Thomas"

    Then 1 document a ete selectionne
    And le "titre" du document 0 est "DSL"
