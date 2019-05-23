class Pokemon
  include Helper
  def initialize(*args, **hash)
    vars = %w(name type db id hp)
    super(vars, args, hash)
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?);", name, type)
    id = db.execute("SELECT last_insert_rowid() FROM pokemon;")[0][0]
  end

  def self.find(id, db)
    id, *pokemon = db.execute("SELECT * FROM pokemon WHERE id = ?;", id)[0]
    *pokemon, hp = pokemon if pokemon.length > 2
    Pokemon.new(*pokemon, db, id, hp)
  end

  def alter_hp(hp, db)
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", hp, @id)
  end
end
