Feature: Je veux pouvoir ordonner des emprunts

  Scenario: Je compare un emprunt avec lui meme

    Given un emprunt "e1" fait par "Guy" ["@"] pour "Code Complete" de "Hunt & Thomas"

    When je compare "e1" et "e1" avec "<="
    Then le resultat de la comparaison est true

    When je compare "e1" et "e1" avec "=="
    Then le resultat de la comparaison est true

    When je compare "e1" et "e1" avec "<"
    Then le resultat de la comparaison est false


  Scenario: Je compare un emprunt avec un emprunt plus grand de nom different

    Given un emprunt "e1" fait par "Guy" ["@"] pour "Code Complete" de "Hunt & Thomas"
    And un emprunt "e2" fait par "Zebulon" ["@"] pour "Pragmatic" de "Hunt & Thomas"

    When je compare "e1" et "e2" avec "<"
    Then le resultat de la comparaison est true

  Scenario: Je compare un emprunt avec un emprunt plus grand pour le meme nom

    Given un emprunt "e1" fait par "Guy" ["@"] pour "Code Complete" de "Hunt & Thomas"
    And un emprunt "e2" fait par "Guy" ["@"] pour "Pragmatic" de "Hunt & Thomas"

    When je compare "e1" et "e2" avec "<"
    Then le resultat de la comparaison est true

    When je compare "e1" et "e2" avec "=="
    Then le resultat de la comparaison est false
