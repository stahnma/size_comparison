# What is this?

A hacky setup to query size deltas in our RPMS (for el7 specifically).

# How does it work?

You start with running `size_checks.rb` on builds.delivery.puppetlabs.net. Capture stdout into a file.

Now put that file on a host where you can install things. Don't do this on builds.delivery.pupeptlabs.net because that host doesn't need this kind of IO going on for a long time.

Ensure you have sqlite3 bindings installed. Then you run `setup_database.rb` with your json file. You might have to edit `setup_database.rb` because I didn't parameterize the arguments.

That loads up an SQLite3 database. Then you run `query.rb` to see what's happening. You can edit THREASHOLD, VERSION1 and VERSION2 in query.rb.


# Example output


    /opt/puppetlabs/puppet/lib/libaugeas.a has min size of 542470 at version 1.5.2 and max of 2493182 at version 1.5.3 for more than a 20% change.
    /opt/puppetlabs/puppet/lib/libfa.a has min size of 120488 at version 1.5.2 and max of 786480 at version 1.5.3 for more than a 20% change.
    /opt/puppetlabs/puppet/lib/libruby-static.a has min size of 4971304 at version 1.5.2 and max of 47253390 at version 1.5.3 for more than a 20% change.
