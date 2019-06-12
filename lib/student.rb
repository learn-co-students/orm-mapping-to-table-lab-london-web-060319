require "pry"

class Student

  # Remember, you can access your database connection anywhere in this class
  #  with DB[:conn]  
  attr_reader(:name, :grade, :id)

  def initialize(name, grade, id = nil)
    @name = name
    @grade = grade
    @id = id
  end

  def self.create_table
    sql = <<-INSERT
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY, 
        name TEXT, 
        grade TEXT
        )
    INSERT
    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = <<-DELETE
      DROP TABLE students
    DELETE
    DB[:conn].execute(sql)
  end

  def save
    sql = <<-SAVE
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SAVE
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
  end

  def self.create(name:, grade:)
    student = Student.new(name, grade)
    student.save
    student
  end
  
end
# binding.pry
# 0
