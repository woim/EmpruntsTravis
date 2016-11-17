# -*- coding: utf-8 -*-
module Emprunts

  #
  # Méthodes pour charger/sauvegarder un dépôt d'emprunts en format
  # texte simple -- des champs avec un séparateur (= %) .
  #
  module EmpruntsTxt

    def self.creer_depot( fich_depot, opts = {:detruire_si_existe => false} )
      DBC.requires( !FileTest.exist?(fich_depot) || opts[:detruire_si_existe],
                    "*** creer_depot: #{fich_depot} existe deja. Indique :detruire_si_existe..." )

      detruire = opts && opts[:detruire_si_existe]

      FileUtils.rm_f( fich_depot ) if FileTest.exist?( fich_depot ) && detruire
      FileUtils.touch( fich_depot )
    end

    def self.charger( fich_depot )
      DBC.requires( FileTest.exist?(fich_depot),
                    "Le fichier #{fich_depot} ne semble pas exister!?" )

      emprunts_pour( fich_depot )
    end


    def self.sauvegarder( fich_depot, les_emprunts )
      DBC.requires( FileTest.exist?(fich_depot),
                    "Le fichier #{fich_depot} ne semble pas exister!?" )

      sauvegarder_depot_existant( fich_depot, les_emprunts )
    end

    private

    SEPARATEUR = "%"

    def self.emprunts_pour( fich_depot )
      les_emprunts = {}
      IO.readlines(fich_depot).each do |l|
        l.chomp!
        nom, courriel, titre, auteurs, perdu = l.split(SEPARATEUR)
        e = Emprunt.new( nom, courriel, titre, auteurs, perdu == "true" )
        les_emprunts[e.titre] = e
      end

      les_emprunts
    end

    def self.sauvegarder_depot_existant( fich_depot, les_emprunts )
      File.open( fich_depot, File::CREAT | File::WRONLY | File::TRUNC ) do |depot|
        les_emprunts.values.each do |emp|
          depot.puts( [emp.nom,
                       emp.courriel,
                       emp.titre,
                       emp.auteurs,
                       emp.perdu?].join(SEPARATEUR) )
        end
      end
    end
  end
end
