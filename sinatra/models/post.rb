require 'sequel'
require 'sqlite3'

class Post
  DB = Sequel.connect('sqlite://db/app.db')
  POSTS_TABLE = DB[:posts]

  attr_accessor :author, :title, :body, :created_at
  attr_reader :id

  def initialize(author, title, body, created_at = nil, id = nil)
    @author = author
    @title = title
    @body = body
    @created_at = Time.now
    @created_at = created_at if created_at
    @id = id if id
  end

  def create!
    POSTS_TABLE.insert(author: @author, title: @title, body: @body, created_at: @created_at)
    new_post_row = POSTS_TABLE.order(:created_at).last
    new_post_row
  end

  def delete!(post_id)
    POSTS_TABLE.where(Sequel[:id] => post_id).delete
  end

  def update!(post_id, author, title, body)
    POSTS_TABLE.where(Sequel[:id] => post_id).update(author: author, title: title, body: body)
    return post_id
  end

  def self.find(post_id)
    unless POSTS_TABLE.all.nil?
    post_row = POSTS_TABLE.first(id: post_id)
    end
    unless post_row.nil?
    Post.new(post_row[:author], post_row[:title], post_row[:body], post_row[:created_at], post_row[:id])
    end
  end

  def day
    day = @created_at[8] + @created_at[9]
    return day.to_i
  end

  def month
    month = @created_at[5]
    month << @created_at[6]
    if month.to_i == 1
      return "January"
    elsif month.to_i == 2
      return "February"
    elsif month.to_i == 3
      return "March"
    elsif month.to_i == 4
      return "April"
    elsif month.to_i == 5
      return "May"
    elsif month.to_i == 6
      return "June"
    elsif month.to_i == 7
      return "July"
    elsif month.to_i == 8
      return "August"
    elsif month.to_i == 9
      return "September"
    elsif month.to_i == 10
      return "October"
    elsif month.to_i == 11
      return "November"
    elsif month.to_i == 12
      return "December"
    else
      return "Error: no month"
    end
  end

  def year
    return "#{@created_at[0]}#{@created_at[1]}#{@created_at[2]}#{@created_at[3]}"
  end
end
