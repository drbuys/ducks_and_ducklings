require( 'pg' )
require_relative( '../db/sql_runner.rb')
require_relative('./duckling.rb')

class MummyDuck

  attr_accessor :id, :name, :address, :duck_type

  def initialize(option)
    @id = option[ 'id' ].to_i
    @name = option[ 'name' ]
    @address = option[ 'address' ]
    @duck_type = option[ 'duck_type' ]
  end

  def save()
    sql = "INSERT INTO mummy_ducks (name, address, duck_type) VALUES ('#{@name}', '#{@address}', '#{@duck_type}') RETURNING *;"
    mummyduck = SqlRunner.run( sql )[0]
    result = MummyDuck.new( mummyduck )
    return result
  end

  def update()
    sql ="UPDATE mummy_ducks
            SET name = '#{@name}',
                address = '#{@address}',
                duck_type = '#{@duck_type}'
            WHERE id = #{@id};"
    mummyduck = SqlRunner.run( sql )
    return mummyduck
  end

  def delete()
    sql = "DELETE FROM mummy_ducks WHERE id = #{@id};"
    mummyduck = SqlRunner.run(sql )
    # deleted = MummyDuck.new( mummyduck )
    return mummyduck
  end

  def self.list()
    sql ="SELECT * FROM mummy_ducks;"
    mummyducks = SqlRunner.run(sql )
    result = mummyducks.map { |mummy| MummyDuck.new( mummy ) }
    return result
  end

  def ducklings()
    sql = "SELECT * FROM ducklings WHERE mummy_id = #{@id};" #working on current instance of artist, so can make use of the instance variables - in this case @id!
    ducklings = SqlRunner.run(sql )
    result = ducklings.map { |baby| Duckling.new( baby ) } #converts every returned hash into new album objects. Creates a nw array of albums
    return result
  end

end
