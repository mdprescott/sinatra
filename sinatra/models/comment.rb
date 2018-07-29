require 'sequel'
require 'sqlite3'

class Comment
  DB = Sequel.connect('sqlite://db/app.db')
  COMMENTS_TABLE = DB[:comments]

  attr_accessor :author, :body, :created_at, :post_id
  attr_reader :id

  def initialize(author, body, post_id = nil, created_at = nil, id = nil)
    @author = author
    @body = body
    @created_at = Time.now
    @created_at = created_at if created_at
    @id = id if id
    @post_id = post_id if post_id
  end

  def create!
    COMMENTS_TABLE.insert(author: @author, body: @body, created_at: @created_at, posts_id: @post_id)
  end

  def delete!(comment_id)
    COMMENTS_TABLE.where(Sequel[:id] => comment_id).delete
  end

  def update!(comment_id, author, body)
    COMMENTS_TABLE.where(Sequel[:id] => comment_id).update(author: author, body: body)
    return post_id
  end

  def self.find(comment_id)
    comment_row = COMMENTS_TABLE.first(id: comment_id)
    unless comment_row.nil?
    Comment.new(comment_row[:author], comment_row[:body], comment_row[:posts_id], comment_row[:created_at], comment_row[:id])
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
