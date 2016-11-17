Feature: Je veux pouvoir avoir des depots sous forme textuelle

  Scenario: Je cree un depot qui n'existe pas deja

    Given il n'existe pas de fichier ".emprunts.txt"

    When je cree un depot texte ".emprunts.txt"

    Then le fichier ".emprunts.txt" existe


  Scenario: Je cree un depot qui existe deja et j'indique que je veux l'ecraser

    Given il existe un fichier ".emprunts.txt"

    When je cree un depot texte ".emprunts.txt" en indiquant de le detruire s'il existe

    Then le fichier ".emprunts.txt" existe
