Feature: Je veux pouvoir ajouter/supprimer des emprunts

  @avec_depot_emprunts_txt
  Scenario: J'emprunte un document

    Given un emprunt "e1" fait par "Joe" ["@"] pour "Clean Code" de "Martin"

    When j'ajoute l'emprunt "e1"

    Then il y a 4 emprunts
    And l'emprunteur de "Clean Code" est "Joe"


  @avec_depot_emprunts_txt
  Scenario: Je supprime un emprunt pour un titre specifique
  
    When je selectionne l'unique emprunt dont le titre est "Code Complete"
    And je supprime l'emprunt selectionne

    When je selectionne les emprunts dont le titre matche "Code Complete"
    Then 0 document a ete selectionne

