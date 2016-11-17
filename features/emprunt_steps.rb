require 'fileutils'
require_relative 'assertions'
require_relative '../emprunt'

#####################################################
# Preconditions.
#####################################################

Given(/^(?:un )?(?:emprunt )?"([^"]*)" fait par "([^"]*)"(?:\s+)\["([^"]*)"\] pour "([^"]*)" de "([^"]*)"$/) do
  |emprunt, nom, courriel, titre, auteurs|
  @emprunts_given ||= {}
  @emprunts_given[emprunt] = Emprunts::Emprunt.new( nom, courriel, titre, auteurs )
end

Given(/^l'emprunt "([^"]*)" est perdu$/) do |emprunt|
  @emprunts_given[emprunt].indiquer_perte
end


#####################################################
# Actions/evenements.
#####################################################

When(/^je formate l'emprunt "([^"]*)" avec "([^"]*)"$/) do |emprunt, format|
  @resultat = @emprunts_given[emprunt].to_s(format)
end

When(/^je formate l'emprunt "([^"]*)"$/) do |emprunt|
  @resultat = @emprunts_given[emprunt].to_s
end

When(/^je compare "([^"]*)" et "([^"]*)" avec "([^"]*)"$/) do |emprunt1, emprunt2, comparateur|
  emp1 = @emprunts_given[emprunt1].to_s
  emp2 = @emprunts_given[emprunt2].to_s

  @resultat = emp1.send comparateur, emp2
end

When(/^j'indique que l'emprunt "([^"]*)" est perdu$/) do |emprunt|
  @emprunts_given[emprunt].indiquer_perte
end


#####################################################
# Postconditions.
#####################################################

Then(/^le resultat de la comparaison est true$/) do
  assert @resultat
end

Then(/^le resultat de la comparaison est false$/) do
  refute @resultat
end

Then(/^la chaine resultante est "([^"]*)"$/) do |resultat|
  assert_equal resultat, @resultat
end

Then(/^l'emprunt "([^"]*)" est considere comme etant perdu$/) do |emprunt|
  assert @emprunts_given[emprunt].perdu?
end
