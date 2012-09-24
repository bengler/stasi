# A command line tool to monitor memory usage of a Pebble under heavy load

# Getting started

    $ git clone https://github.com/bengler/stasi.git

    $ cd stasi && rake install

    $ stasi <pebble name> <endpoint to call>

# Future improvements / ideas

- Better separation of concerns (i.e. pid monitoring and issuing endpoint requests should be in separate places)
- Possibility to specify a command to run (and monitor the pid of that command)