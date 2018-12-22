  def seed_users
    User.create(name: "test1", 
                email: "test1@test.com", 
                institute: "IIITB", 
                password: '123456', 
                password_confirmation: '123456' )
    User.create(name: "test2", 
                email: "test2@test.com", 
                institute: "IITR", 
                password: '123456', 
                password_confirmation: '123456' )
    User.create(name: "test3", 
                email: "test3@test.com", 
                institute: "IIITH", 
                password: '123456', 
                password_confirmation: '123456' )
  end
  
  
  def seed_categories
    hobby = ['Arts', 'Crafts', 'Sports', 'Sciences', 'Collecting', 'Reading', 'Other']
    study = ['Arts and Humanities', 'Physical Science and Engineering', 'Math and Logic',
            'Computer Science', 'Data Science', 'Economics and Finance', 'Business',
            'Social Sciences', 'Language', 'Other']
    team = ['Study', 'Development', 'Arts and Hobby', 'Other']
  
    hobby.each do |name|
      Category.create(branch: 'hobby', name: name)
    end
  
    study.each do |name|
      Category.create(branch: 'study', name: name)
    end
  
    team.each do |name|
      Category.create(branch: 'team', name: name)
    end
  end
  
  def seed_posts
    categories = Category.all
  
    categories.each do |category|
      3.times do
        Post.create(
          title: Faker::Lorem.sentences[0], 
          content: Faker::Lorem.sentences[0], 
          user_id: rand(1..3), 
          category_id: category.id
        )
      end
    end
  end

  def seed_groups
    Group.create(name: "IIITB")
    Group.create(name: "IITR")
    Group.create(name: "IIITH")
  end

  
  seed_users
  seed_categories
  seed_posts
  seed_groups
  