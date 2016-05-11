require( 'pg' )
require_relative( '../db/sql_runner.rb')
require_relative('./duckling.rb')

class Duckling

  attr_accessor :id, :name, :hobby, :age

  def initialize(option)
    @id = option[ 'id' ].to_i
    @name = option[ 'name' ]
    @hobby = option[ 'hobby' ]
    @age = option[ 'age' ].to_i
    @mummy_id = option[ 'mummy_id' ].to_i
  end

  def save()
    sql = "INSERT INTO ducklings (name, hobby, age, mummy_id) VALUES ('#{@name}', '#{@hobby}', #{@age}, #{@mummy_id}) RETURNING *;"
    duckling = SqlRunner.run( sql )[0]
    result = Duckling.new( duckling )
    return result
  end

  def update()
    sql ="UPDATE ducklings
            SET name = '#{@name}',
                hobby = '#{@hobby}',
                age = #{@age},
                mummy_id = #{@mummy_id}
            WHERE id = #{@id};"
    duckling = SqlRunner.run( sql )[0]
    result = Duckling.new( duckling )
    return result
  end

  def delete()
    sql = "DELETE FROM ducklings WHERE id = #{@id};"
    mummyduck = SqlRunner.run(sql )
    # deleted = MummyDuck.new( mummyduck )
    return mummyduck
  end

  def self.list()
    sql ="SELECT * FROM ducklings;"
    ducklings = SqlRunner.run(sql )
    result = ducklings.map { |duckling| Duckling.new( duckling ) }
    return result
  end

  def mummy_duck()
    sql = "SELECT * FROM mummy_ducks WHERE mummy_ducks.id = #{@mummy_id};"
    mummyduck = SqlRunner.run(sql )[0]
    result = MummyDuck.new( mummyduck )
    return result
  end

end
