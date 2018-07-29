require 'sinatra'
require 'sequel'
require 'sqlite3'
require './models/post'
require './models/comment'

DB = Sequel.connect('sqlite://db/app.db')
comments = DB[:comments]
post_comments = comments.select(:id).where(posts_id: 1)
comment_row = post_comments.order(:created_at).last[:id]
variable = post_comments.count

comment_row = 22
comment_print = post_comments.where(:id => comment_row).get(:id)

puts comment_row
puts comment_print
puts post_comments
puts variable
