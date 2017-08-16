require("pry-byebug")
require_relative("../models/albums")
require_relative("../models/artists")

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new ({'name' => 'Switchfoot'})

artist2 = Artist.new ({'name' => '3 Doors Down'})

artist3 = Artist.new ({'name' => 'Paramore'})

artist1.save()
artist2.save()
artist3.save()

album1 = Album.new ({'artists_id' => artist1.id, 'name' => 'Oh! Gravity', 'genre' => 'Rock'})

album2 = Album.new ({'artists_id' => artist1.id, 'name' => 'Fading West', 'genre' => 'Rock'})

album3 = Album.new ({'artists_id' => artist2.id, 'name' => 'Time Of My Life', 'genre' => 'Indie'})

album4 = Album.new ({'artists_id' => artist2.id, 'name' => 'Us And The Night', 'genre' => 'Indie'})

album5 = Album.new ({'artists_id' => artist3.id, 'name' => 'Riot!', 'genre' => 'Rock'})

album6 = Album.new ({'artists_id' => artist3.id, 'name' => 'After Laughter', 'genre' => 'Rock'})

album1.save()
album2.save()
album3.save()
album4.save()
album5.save()
album6.save()

binding.pry
nil
