This is a [Dashing](http://shopify.github.io/dashing/) widget to display train service times and disruptions on a Dashing dashboard.

## Installation

Make sure you add the <tt>ns-api</tt> gem to your Gemfile:

    gem 'ns-api', git: 'git://github.com/marceldegraaf/ns.git', require: 'ns'

Follow [the instructions](https://github.com/marceldegraaf/ns#request-an-api-username-and-password-from-ns) to
request your NS API credentials and set these in the <tt>Train</tt> class - or use the <tt>ENV</tt> vars that
are already present there.

## Usage

Add the widget to your dashboard:

    <li data-row="1" data-col="1" data-sizex="1" data-sizey="1">
      <div data-id="ns" data-view="Ns" data-title="Train info"></div>
    </li>

In the <tt>jobs/ns.rb</tt> file there is an example of data retrieval for the Dashing widget. The <tt>Train</tt>
class is responsible for interacting with the NS API gem in this case, but you could easily move this code into
the job itself.
