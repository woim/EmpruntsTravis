#-*- ruby -*-

require 'rake/clean'
require 'cucumber'
require 'cucumber/rake/task'

FORMAT="--format progress"
#FORMAT="--format pretty"

######################################################################
# Taches par defaut et taches associees aux differentes groupes de
# features et exercices.
######################################################################

task :default => :WIP

#
# Supprimer le # pour traiter le bon exercice -- ou les deux exercices.
#
task :WIP => :outline1
#task :WIP => :outline2

#
# Pour executer toutes les features.
#
#task :WIP => :features

task :outline1 do
  sh "cucumber #{FORMAT} features/emprunts-outline1.feature"
end

task :outline2 do
  sh "cucumber #{FORMAT} features/emprunts-outline2.feature"
end

task :emprunts_features do
  sh "cucumber #{FORMAT} features/emprunts-ouvrir.feature"
  sh "cucumber #{FORMAT} features/emprunts-selectionner.feature"
  sh "cucumber #{FORMAT} features/emprunts-ajouter-supprimer.feature"
end

task :emprunts_txt_features do
  sh "cucumber #{FORMAT} features/emprunts_txt.feature"
end

task :emprunt_features do
  sh "cucumber #{FORMAT} features/emprunt-to_s.feature"
  sh "cucumber #{FORMAT} features/emprunt-spaceship.feature"
  sh "cucumber #{FORMAT} features/emprunt-perte.feature"
end


##################################################
# Cucumber
##################################################
CUKE_RESULTS = 'results.html'
CLEAN << CUKE_RESULTS

desc 'Run features'
Cucumber::Rake::Task.new(:features) do |t|
  opts = "features --format progress -x"
  opts += " --tags #{ENV['TAGS']}" if ENV['TAGS']
  t.cucumber_opts =  opts
  t.fork = false
end

desc 'Run features tagged as work-in-progress (@wip)'
Cucumber::Rake::Task.new('features:wip') do |t|
  tag_opts = ' --tags ~@pending'
  tag_opts = ' --tags @wip'
  t.cucumber_opts = "features --format progress -x -s#{tag_opts}"
  t.fork = false
end

