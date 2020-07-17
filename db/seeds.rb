tom = User.create(username: "tbanish", email: "tom@tom.com", password: "test")
james = User.create(username: "jbanish", email: "james@james.com", password: "test")
nicole = User.create(username: "ngomez", email: "nicole@nicole.com", password: "test")

Book.create(title: "The Sun Also Rises", author: "Ernest Hemingway", user_id: tom.id)
Book.create(title: "Blood Meridian", author: "Cormac McCarthy", user_id: tom.id)

Book.create(title: "The Stand", author: "Stephen King", user_id: james.id)
Book.create(title: "Catcher in the Rye", author: "JD Salinger", user_id: james.id)

Book.create(title: "American Pastoral", author: "Philip Roth", user_id: nicole.id)
Book.create(title: "Sharp Objects", author: "Gyllian Flynn", user_id: nicole.id)
