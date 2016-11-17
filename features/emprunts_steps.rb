require 'fileutils'
require_relative 'assertions'
require_relative '../emprunts'

#####################################################
# Preconditions.
#####################################################

# Voir support/hooks.rb


#####################################################
# Actions/evenements.
#####################################################

When(/^j'ouvre les emprunts pour le depot "([^"]*)"$/) do |fichier|
  @emprunts_repository = Emprunts::Emprunts.ouvrir( fichier )
end

When(/^je selectionne les emprunts faits par "([^"]*)"$/) do |nom|
  @selection = @emprunts_repository.selectionner do |e|
    e.nom == nom
  end
end

When(/^je selectionne les emprunts dont le titre matche "([^"]*)"$/) do |patron|
  @selection = @emprunts_repository.selectionner do |e|
    e.titre =~ /#{patron}/
  end
end

When(/^je selectionne l'unique emprunt dont le titre est "([^"]*)"$/) do |titre|
  @selection = @emprunts_repository.selectionner( unique: true ) do |e|
    e.titre == titre
  end
end

When(/^je selectionne les emprunts tels que le "([^"]*)" matche "([^"]*)"$/) do |champ, patron|
  @selection = @emprunts_repository.selectionner do |e|
    e.send(champ) =~ /#{patron}/
  end
end

When(/^j'ajoute l'emprunt "([^"]*)"$/) do |emp|
  @emprunts_repository.ajouter( @emprunts_given[emp] )
end

When(/^je supprime l'emprunt selectionne$/) do
  @emprunts_repository.supprimer( @selection )
end

#####################################################
# Postconditions.
#####################################################

Then(/^il n'y a aucun emprunt$/) do
  assert_equal @emprunts_repository.size, 0
end

Then(/^il y a (\d+) emprunts$/) do |nb|
  assert_equal @emprunts_repository.size, nb.to_i
end

Then(/^l'emprunteur de "([^"]*)" est "([^"]*)"$/) do |titre, nom|
  emp = @emprunts_repository.selectionner( unique: true ) do |e|
    e.titre == titre
  end
  assert_equal nom, emp.nom
end

Then(/^(\d+) document(?:s)? (?:a|ont) ete selectionne(?:s)?$/) do |nb|
  assert_equal nb.to_i, @selection.size
end

Then(/^le titre du document (\d+) est "([^"]*)"$/) do |num, titre_attendu|
  assert_equal titre_attendu, @selection[num.to_i].titre
end

Then(/^le titre de l'unique document selectionne est "([^"]*)"$/) do |titre|
  assert_equal titre, @selection.titre
end

Then(/^le "([^"]*)" du document (\d+) est "([^"]*)"$/) do |champ, num, valeur|
  assert_equal valeur, @selection[num.to_i].send(champ)
end
