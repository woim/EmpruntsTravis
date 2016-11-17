# -*- coding: utf-8 -*-
module Emprunts
  require_relative 'debug'
  require_relative 'dbc'
  require_relative 'emprunts-txt'
  require_relative 'emprunt'

  #
  # Dépôt pour une collection d'emprunts (*repository*).
  #
  class Emprunts
    private
    def self.existe?( fich_depot )
      FileTest.exist?( fich_depot )
    end

    public

    #
    # Crée le dépôt.
    #
    def self.creer_depot( fich_depot, opts = {:detruire_si_existe => false} )
      Debug.log( "Emprunts.creer_depot( #{fich_depot}, #{opts} )" )

      ext = File.extname(fich_depot)
      detruire = opts && opts[:detruire_si_existe]

      fail "** Erreur: format non traite: #{ext}" unless ext == '.txt'
      fail "*** Erreur: depot existe deja: #{fich_depot}" if existe?( fich_depot ) && !detruire

      EmpruntsTxt.creer_depot( fich_depot, opts )
    end

    #
    # Ouvre le dépôt à partir du fichier indiquée.
    # Si un bloc est transmis, alors la sauvegarde se fait implicitement,
    # à moins que l'option :sauvegarder soit false (valeur par défaut).
    # De plus, on ne sauvegarde pas si une exception est lancee!
    #
    def self.ouvrir( fich_depot, opts = {:sauvegarder => false} )
      Debug.log( "Emprunts.ouvrir( #{fich_depot}, #{opts} )" )
      DBC.requires existe?( fich_depot ), "Le fichier depot '#{fich_depot}' n\'existe pas!%"

      emps = new( fich_depot )

      if block_given?
        yield emps
        emps.fermer if opts && opts[:sauvegarder]
      else
        emps
      end
    end

    def initialize( fich_depot ) # :nodoc:
      Debug.log( "Emprunts#initialize( #{fich_depot} )" )

      ext = File.extname(fich_depot)
      @le_depot = EmpruntsTxt

      fail "*** Erreur: format non traite: #{ext}" unless @le_depot

      @les_emprunts = @le_depot.charger( fich_depot )

      @fich_depot = fich_depot
      @modifie = false
    end

    private_class_method :new

    #
    # Nombre d'emprunts.
    #
    def size
      @les_emprunts.size
    end

    #
    # Retourne un tableau contenant les emprunts qui satisfont le selecteur.
    #
    # Si ":unique => true" est specifie, alors retourne l'unique emprunt approprie...
    # s'il est effectivement unique, sinon signale une erreur.
    #
    # Si le selecteur (bloc) est absent, alors equivalent a "{|e| true}" donc tous
    # les emprunts sont retournes.
    #
    def selectionner( opts = {:unique => false}, &selecteur )
      Debug.log( "Emprunts#selectionner[#{self.inspect}]( #{opts} )" )

      selecteur = ->(e) { true } unless block_given?

      es = @les_emprunts.values.
        select { |e| selecteur.call(e) }

      if opts[:unique]
        fail "*** Erreur: Pas juste un emprunt: #{es.inspect}" unless es.size == 1
        es[0]
      else
        es
      end
    end

    #
    # Ajoute l'emprunt indiqué.
    #
    def ajouter( emp )
      titre = emp.titre
      DBC.requires @les_emprunts[titre].nil?, "Le titre \'#{titre}\' est deja emprunte!?"

      @les_emprunts[titre] = emp
      @modifie = true
    end

    #
    # Supprime l'emprunt indiqué.
    #
    def supprimer( emp )
      titre = emp.titre
      e = @les_emprunts[titre]
      DBC.requires e, "Le titre \'#{titre}\' n\'existe pas!?"

      @les_emprunts.delete(titre)
      @modifie = true
    end

    #
    # Indique que l'emprunt indiqué a été perdu.
    #
    def indiquer_perte( emp )
      emp.indiquer_perte
      @modifie = true
    end

    #
    # Sauve l'état du dépôt dans le fichier, à moins qu'il n'y ait eu aucune
    # modification aux emprunts.
    #
    def fermer
      Debug.log( "Emprunts#fermer[#{self.inspect}]" )

      return unless @les_emprunts

      DBC.requires @fich_depot, "Le fichier pour le depot n\'est pas defini!?"

      return unless @modifie

      @le_depot.sauvegarder( @fich_depot, @les_emprunts )
      @modifie = false
    end
  end
end
