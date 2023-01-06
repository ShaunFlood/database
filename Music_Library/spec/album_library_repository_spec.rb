require 'album_library_repository'

def reset_album_library_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

RSpec.describe AlbumLibraryRepository do
  before(:each) { reset_album_library_table }

  # (your tests will go here).
  xit '' do
    library = AlbumLibraryRepository.new
    expect(library.all.length).to eq 12
  end

  xit '' do
    library = AlbumLibraryRepository.new
    expect(library.all[0].title).to eq "Doolittle"
    expect(library.all[0].id).to eq "1"
  end

  xit 'returns all the titles in the database' do
    library = AlbumLibraryRepository.new
    expect(library.title[0].title).to eq "Doolittle"
  end
  it 'test the find function' do
    library = AlbumLibraryRepository.new
    library.find(1)
    expect(library.title).to eq('Doolittle')
    expect(library.id).to eq ('1')
  end
end