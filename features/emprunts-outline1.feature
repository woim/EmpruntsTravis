Feature: Je veux pouvoir ajouter/supprimer des emprunts

  @avec_depot_vide
  Scenario Outline: J'emprunte un document parmi plusieurs possibles

    Given un emprunt "e1" fait par "Joe"     ["@"] pour "Clean Code" de "Martin"
    And   un emprunt "e2" fait par "Jack"    ["@"] pour "The Clean Coder" de "Martin"
    And   un emprunt "e3" fait par "Averell" ["@"] pour "The Pragmatic Programmer" de "Hunt \& Thomas"

    When j'ajoute l'emprunt "<e>"

    Then l'emprunteur de "<titre>" est "<emprunteur>"

    Examples:
    | e  | titre                    | emprunteur |
    # A COMPLETER!
    | e1 | TITRE               | QUI        | 
