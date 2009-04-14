    # Add columns to automatically generated tables
    add_column 'users', 'company_id', :integer

    # Create companies
    Company.reset_column_information
    cracktastic = Company.new :is_self => true, :name => 'Cracktastic Ltd',
        :contact_name => 'Accounts Dept', :address => "Cracker House\nThe Avenue",
        :city => 'Magictown', :postal_code => 'AA1 9ZZ', :country => 'United Kingdom',
        :country_code => 'GB', :tax_number => 'GB 123 4567 890'
    cracktastic.save!
    customer = Company.new :is_self => false, :name => 'Customer Ltd',
        :contact_name => 'Michael Smith', :address => "42 Foo Lane",
        :city => 'London', :postal_code => 'SW1 2BC', :country => 'United Kingdom',
        :country_code => 'GB'
    customer.save!

    # Create users
    User.reset_column_information
    user = User.new :login => 'admin', :email => 'admin@example.com',
        :password => 'asdfasdf', :password_confirmation => 'asdfasdf'
    user.company = cracktastic
    user.register!
    user.activate!
    user = User.new :login => 'test', :email => 'test@example.com',
        :password => 'asdfasdf', :password_confirmation => 'asdfasdf'
    user.company = customer
    user.register!
    user.activate!

    # Create jokes
    jokes = [
        # Borrowed from http://www.telegraph.co.uk/news/uknews/1573066/Top-ten-worst-Christmas-cracker-jokes-ever.html
        ['What do you call a short sighted dinosaur?', 'A do-you-think-he-saurus.'],
        ['What do you call a man with brown paper trousers?', 'Russell.'],
        ['What do you call a man with a pole through his leg?', 'Rodney.'],
        ['Why would you invite a mushroom to a Christmas party?', 'He\'s a fun guy to be with.'],
        ['Why was Santa\'s little helper feeling depressed?', 'He had low elf-esteem.'],
        ['Why should husbands make the early morning tea for their wives?', 'Because the Bible says He Brews.'],
        ['What\'s the longest word in the English language?', 'Smiles, because there is a "mile" between the first and the last letters.'],
        ['On which side do chickens have the most feathers?', 'The outside.'],
        ['What kind of paper likes music?', '(W)rapping paper.'],
        ['What\'s white and goes up?', 'A confused snowflake.'],
        ['What do you call a woman who stands between two goal posts?', 'Annette.'],
        ['Did you hear about the man who bought a paper shop?', 'It blew away.'],
        ['What\'s furry and minty?', 'A polo bear.'],
        ['How do snowmen get around?', 'They ride an icicle.'],
        ['Who hides in the bakery at Christmas?', 'A mince spy.'],
        ['What do you call a penguin in the Sahara desert?', 'Lost.'],
        ['What did the stamp say to the letter?', 'Stick with me and we\'ll go places.'],
        ['What do you call a three legged donkey?', 'A wonkey.'],
        ['Why did the Buddhist refuse the dentist\'s anaesthetic?', 'He wanted to transcend dental medication.'],
        ['Why are pirates great?', 'They just aaaaaaarrrrr.'],
        ['What kind of lights did Noah have on the Ark?', 'Floodlights.'],
        ['Why was the scarecrow awarded the nobel prize?', 'Because he was outstanding in his field.'],
        ['Why do Marxists only drink herbal tea?', 'Because proper tea is theft.'],
        ['Why are there no aspirins in the jungle?', 'Because the parrots eat \'em all.'],

        # Borrowed from http://news.bbc.co.uk/1/hi/uk/2601789.stm
        ['What\'s grey, yellow, grey, yellow, grey, yellow, grey, yellow, grey, yellow?', 'An elephant rolling down a hill with a daisy in its mouth.'], 
        ['What happened when the ship carrying red paint and the ship carrying blue paint collided at sea?', 'All the sailors ended up being marooned.'],
        ['What did the fish say when it swam into a wall?', 'Dam.'],
        ['What athlete is warmest in winter?', 'A long jumper.'],
        ['What did the grape say when the elephant stepped on it?', 'Nothing. It just let out a little wine.'],
        ['Why did the man get sacked from the orange juice factory?', 'Because he couldn\'t concentrate.'],
        ['What sort of sentence would you get if you broke the law of gravity?', 'A suspended one!']
    ]

    jokes.each{|joke| Joke.create :question => joke[0], :answer => joke[1] }
