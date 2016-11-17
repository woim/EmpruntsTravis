Feature: Je veux pouvoir ouvrir un depot contenant des emprunts

  Scenario: J'ouvre un depot avec des givens explicites

    Given un fichier ".emprunts.txt" contenant les emprunts suivants:
    """
    Guy%@%Code Complete%McConnel%
    Guy%@%Pragmatic Programmer%Hunt & Thomas%
    Thomas%@%DSL%Fowler%TRUE
    """

    When j'ouvre les emprunts pour le depot ".emprunts.txt"

    Then il y a 3 emprunts
    And l'emprunteur de "Code Complete" est "Guy"
    And l'emprunteur de "Pragmatic Programmer" est "Guy"
    And l'emprunteur de "DSL" est "Thomas"


  # REMARQUE: L'utilisation de l'annotation @avec_depot_emprunts_txt
  # avant le mot-cle "Scenario" assure que la "mini-BD"
  # (.emprunts.txt) avec les trois emprunts du scenario ci-haut seront
  # automatiquement charges au debut de l'execution du scenario -- et
  # le fichier detruit automatiquement apres l'execution du scenario.
  # Voir le fichier support/hooks.rb pour les steps associes.

  @avec_depot_emprunts_txt
  Scenario: J'ouvre un depot avec la cretaion/ouverture implicite

    Then il y a 3 emprunts
    And l'emprunteur de "Code Complete" est "Guy"
    And l'emprunteur de "Pragmatic Programmer" est "Guy"
    And l'emprunteur de "DSL" est "Thomas"

