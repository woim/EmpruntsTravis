Before '@avec_depot_vide' do
  contenu = []
  File.open( '.emprunts.txt', "w" ) do |fich|
    fich.puts contenu
  end

  @emprunts_repository = Emprunts::Emprunts.ouvrir( '.emprunts.txt' )
end

After '@avec_depot_vide' do
  FileUtils.rm_f '.emprunts.txt'
end

Before '@avec_depot_emprunts_txt' do
  contenu = [ 'Guy%@%Code Complete%McConnell%',
              'Guy%@%Pragmatic Programmer%Hunt & Thomas%',
              'Thomas%@%DSL%Fowler%TRUE' ]
  File.open( '.emprunts.txt', "w" ) do |fich|
    fich.puts contenu
  end

  @emprunts_repository = Emprunts::Emprunts.ouvrir( '.emprunts.txt' )
end

After '@avec_depot_emprunts_txt' do
  FileUtils.rm_f '.emprunts.txt'
end
