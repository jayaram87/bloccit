require 'random_data'

50.times do
    Post.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph)
end
posts = Post.all

100.times do
    Comment.create!(post: posts.sample, body: RandomData.random_paragraph)
end

unique_post = Post.find_or_create_by(title: "Unique Post", body: "Unique Post Body")
unique_comment = unique_post.comments.find_or_create_by(body: "Unique Comment")

puts "#{unique_post.title} title of Unique post"
puts "#{unique_comment.body} unique comment"
puts "Seed finished"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"