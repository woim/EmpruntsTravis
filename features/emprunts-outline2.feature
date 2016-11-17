Feature: Je veux pouvoir ajouter/supprimer des emprunts
  @avec_depot_vide
  Scenario Outline: Je retourne un document parmi plusieurs possibles

    Given un emprunt "e1" fait par "Joe"     ["@"] pour "Refactoring" de "Fowler"
    And   un emprunt "e2" fait par "Jack"    ["@"] pour "Clean Code" de "Martin"
    And   un emprunt "e3" fait par "Averell" ["@"] pour "DSL" de "Fowler"
    And   j'ajoute l'emprunt "e1"
    And   j'ajoute l'emprunt "e2"
    And   j'ajoute l'emprunt "e3"

    When je selectionne l'unique emprunt dont le titre est "<titre1>"
    And je supprime l'emprunt selectionne

    When je selectionne les emprunts dont le titre matche "<titre2>"
    Then <n> documents ont ete selectionnes
    And il y a <k> emprunts


    Examples:
    # A COMPLETER!
    # Ici, on aimerait s'assurer de tester toutes les combinaisons possibles!
