Feature: Je veux pouvoir prendre note de la perte d'un document emprunte

  Scenario: Le document n'est perdu et j'indique sa perte

    Given un emprunt "e1" fait par "Guy" ["@"] pour "Code Complete" de "Hunt & Thomas"

    When j'indique que l'emprunt "e1" est perdu

    Then l'emprunt "e1" est considere comme etant perdu


  Scenario: Le document est deja perdu et j'indique qu'il est perdu

    Given un emprunt "e1" fait par "Guy" ["@"] pour "Code Complete" de "Hunt & Thomas"
    And l'emprunt "e1" est perdu

    When j'indique que l'emprunt "e1" est perdu

    Then l'emprunt "e1" est considere comme etant perdu
