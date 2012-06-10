Well, that was fun.  So, first thing's first, how to run the code:

- Extract tar.gz file
- Bundle install
- Load the initial data set with: bin/lpbooker load_data traveller.json accommodation.json (takes about 45 seconds)
- As per the instructions run one of the 'bin/lpbooker' commands: accommodation, traveller or search

-------------------

Now, a bit about my thought process and the way I attacked the exercise.

I actually took a lot longer on this than I had originally thought I would, but a lot of that time was due to thinking through the task and how I might approach it.
After reading the instructions a couple of times I had a bunch of different things going through my mind, the biggest of which was how I was going to attack the data.
Surely you didn't want me to just read the json files in in memory and do some manipulation of the data there.  I started tossing around the ideas of dumping the data in a sqlite3
or Reddis database or even indexing it with Ferret to make it easy for the search.  I tossed up writing a tiny sinatra app that would give me a nice RESTful interface to the data.

So I just started writing some specs to see where things ended up and I started loading the data into a sqlite database, allowing me to manipulate the data as objects and link the travellers
with the accommodations for the bookings.

However, after writing the code to dump the data into sqlite3, it just took too long to save the accommodation data, let alone the 10000 travellers.  This obviously wasn't the
solution you were looking for.

So I re-read the instructions again and I noticed how you were passing the name of the json files into each command line call.  While I'd initially written the thought of just loading
the json files up for each call as inefficient and not a great solution I started to think that maybe that was the solution to go for.  Something not too over engineered for what this is,
a coding example.  So, that's the way I ended up going.

Basically, the data load process loads the initial seed data files up and matches the travellers to the accommodations and saves them by the file names provided in the call.  Travellers are
saved with the accommodation id for which they have been booked and accommodations are saved with the traveller id's for the guests that are booked there.

From then on, the other commands simply load the linked data up and query it.

----- Code architecture

There are basically 3 main files that run:
  - booking_matcher.rb links the travellers to the accommodations
  - search.rb searches the data for the travellers, accommodations and availabilities
  - cli_manager.rb manages the interactions between the command line tool and the above two files.


----- Specs
I thought I'd give MiniTest a crack for the specs so feel free to run them.  This was done in a completely TDD fashion, as git log will show you.  My preferred method of working is to
start with the spec and write the methods and subject class required in there until such time that it makes sense to pull it out in to it's own class.


------ Notes
Just to address the comment in the instructions about how this would perform with larger data sets, in a word, not good.  At the moment while there are 1000's of entries we are fine, but once
you start getting up in to the millions, you aren't going to want to be doing this in memory.  I'd hope that you are storing the data in some of db, and possibly using some sort of full text
index for searching of the data.