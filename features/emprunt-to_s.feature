Feature: Je veux pouvoir afficher un emprunt selon divers formats

  Scenario: Je formate un emprunt avec le format par defaut

    Given un emprunt "e1" fait par "Guy" ["@"] pour "Code Complete" de "Hunt & Thomas"

    When je formate l'emprunt "e1"

    Then la chaine resultante est "[ Guy @ 'Code Complete' 'Hunt & Thomas' ]"


  Scenario: Je formate un emprunt perdu avec le format par defaut

    Given un emprunt "e1" fait par "Guy" ["@"] pour "Code Complete" de "Hunt & Thomas"

    And l'emprunt "e1" est perdu

    When je formate l'emprunt "e1"

    Then la chaine resultante est "[ Guy @ 'Code Complete' 'Hunt & Thomas' ]"


  Scenario: Je formate un emprunt avec un format specifique

    Given un emprunt "e1" fait par "Guy" ["@"] pour "Code Complete" de "Hunt & Thomas"

    When je formate l'emprunt "e1" avec "%N => '%T'"

    Then la chaine resultante est "Guy => 'Code Complete'"

