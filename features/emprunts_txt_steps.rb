require_relative 'assertions'
require_relative '../emprunts-txt'

#####################################################
# Preconditions.
#####################################################

Given(/^il n'existe pas de fichier "([^"]*)"$/) do |fichier|
  FileUtils.rm_f fichier
end

Given(/^il existe un fichier "([^"]*)"$/) do |fichier|
  FileUtils.touch fichier
end

Given(/^un fichier "([^"]*)" contenant(?: les emprunts suivants)?:$/) do |fichier, contenu|
  File.open( fichier, "w" ) do |fich|
    fich.puts contenu
  end
end

#####################################################
# Actions/evenements.
#####################################################

When(/^je cree un depot texte "([^"]*)" en indiquant de le detruire s'il existe$/) do |depot|
  Emprunts::EmpruntsTxt.creer_depot( depot, detruire_si_existe: true )
end

When(/^je cree un depot texte "([^"]*)"$/) do |depot|
  Emprunts::EmpruntsTxt.creer_depot( depot )
end

#####################################################
# Postconditions.
#####################################################

Then(/^le fichier "([^"]*)" existe$/) do |fichier|
  File.exist? fichier
end
