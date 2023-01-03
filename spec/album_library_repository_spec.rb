require 'album_library_repository'

def reset_album_library_table
  seed_sql = File.read('spec/seeds.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
  connection.exec(seed_sql)
end

RSpec.describe AlbumLibraryRepository do
  before(:each) { reset_album_library_table }

  # (your tests will go here).
  it '' do
    library = AlbumLibraryRepository.new
    expect(library.all.length).to eq 12
  end
end