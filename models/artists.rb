require('pg')
require_relative('../db/sql_runner')

class Artist

  attr_accessor(:name)
  attr_reader(:id)

  def initialize(params)
    @id = params['id'].to_i() if params ['id']
    @name = params['name']
  end

  def album
    sql = '
      SELECT * FROM albums
      WHERE artists_id = $1;'
    albums_hashes = SqlRunner.run(sql, [@id])

    albums = albums_hashes.map { |album_hash| Album.new(album_hash) }

    return albums
  end

  def Artist.all
    sql = 'SELECT * FROM artists;'
    results = SqlRunner.run(sql)

    artists = []
    for result_hash in results do
      artists_object = Artist.new(result_hash)
      artists.push(artists_object)
    end

    return artists
  end


  def save
    db = PG.connect({dbname: 'music_collection', host: 'localhost'})
    sql = '
      INSERT INTO artists (
        name
        ) VALUES (
        $1
        )
        RETURNING *;'
    db.prepare('save', sql)

    returned_data = db.exec_prepared('save', [@name])
    db.close()

    returned_hash = returned_data[0]

    id = returned_hash['id']

    @id = id.to_i()

  end

  def Artist.delete_all
    db = PG.connect({dbname: 'music_collection', host: 'localhost'})
    sql = 'DELETE FROM artists;'
    db.exec(sql)
    db.close()
  end

  def update()
    db = PG.connect( { dbname: 'music_collection', host: 'localhost' } )
    sql = '
      UPDATE artists SET (
      name
      ) = (
      $1
      )
      WHERE id = $2;'
    values = [@name, @id]
    db.prepare('update', sql)
    db.exec_prepared('update', values)
    db.close()
  end

  def delete()
    db = PG.connect( { dbname: 'music_collection', host: 'localhost' } )
    sql = 'DELETE FROM artists
    WHERE id = $1;'
    values = [@id]
    db.prepare('delete', sql)
    db.exec_prepared('delete', values)
    db.close()
  end

end
