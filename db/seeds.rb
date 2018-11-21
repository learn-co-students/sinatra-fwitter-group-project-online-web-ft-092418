peter = User.create(username: "peter", email: "pmail", password: "peterpass")

annie = User.create(username: "annie", email: "amail", password: "anniepass")

sophie = User.create(username: "sophie", email: "smail", password: "sophiepass")



t = peter.tweets.build(content: "p v first tweet")
t.save

t = annie.tweets.build(content: "a v first tweet")
t.save


t = sophie.tweets.build(content: "s v first tweet")
t.save

t = peter.tweets.build(content: "gov't is bad, ya hear")
t.save


t = annie.tweets.build(content: "books are great")
t.save

t = sophie.tweets.build(content: "I like running")
t.save

t = peter.tweets.build(content: "power to the people")
t.save

t = annie.tweets.build(content: "I like books a lot")
t.save

t = sophie.tweets.build(content: "running really really far is fun")
t.save
