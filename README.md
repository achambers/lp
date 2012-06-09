Thought of many ways to go about doing this, storing the data, indexing the data etc etc.

Was first thinking about loading the data into an sqlite3 database.  Then thought I could just use Ferret to index the data, making it easy to search.
Then thought maybe I should just dump it all in Reddis.

Then I went back and re-read the instructions yet again and noticed that the command line tool provided specifies the two json files for each call, making me wonder what that
is used for if I am meant to process the data before hand.

Maybe the simplest thing to do is just generate a new JSON based data set after processing the data...Or, maybe I should just modify the existing data sets.

Obviously, doing this means we will be dealing with the JSON in memory which is cool for the number of records we are going to be using.  If we start getting into the millions, however,
we would want to look at doing something along the lines of the above ideas with moving the data into another data store such as Reddis or Postgres.
