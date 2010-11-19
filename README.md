UniformNotifier
===============

uniform_notifier is extracted from [bullet][0], it gives you the ability to send notification through rails logger, customized logger, javascript alert, javascript console, growl, and xmpp.

Install
-------

* install directly

    gem install uniform_notifier

  if you want to notify by growl or xmpp, you should install them first

    gem install ruby-growl
    gem install xmpp4r

* add it into Gemfile (Bundler)

    gem "uniform_notifier"

  you should add ruby-growl and xmpp4r gem if you want.

Usage
-----

There are two types of notifications,
one is <code>inline_notify</code>, for javascript alert and javascript console notifiers, which returns a string and will be combined,
the other is <code>out_of_channel_notify</code>, for rails logger, customized logger, growl and xmpp, which doesn't return anything, just send the message to the notifiers.

By default, all notifiers are disabled, you should enable them first.

    # javascript alert
    UniformNotifier.alert = true

    # javascript console
    UniformNotifier.console = true

    # rails logger
    UniformNotifier.rails_logger = true

    # customized logger
    logger = File.open('notify.log', 'a+')
    logger.sync = true
    UniformNotifier.customized_logger = logger

    # growl without password
    UniformNotifier.growl = true
    # growl with passowrd
    UniformNotifier.growl = { :password => 'growl password' }

    # xmpp
    UniformNotifier.xmpp = { :account => 'bullets_account@jabber.org',
                             :password => 'bullets_password_for_jabber',
                             :receiver => 'your_account@jabber.org',
                             :show_online_status => true }

After that, you can enjoy the notifiers, that's cool!

    # the notify message will be notified to rails logger, customized logger, growl or xmpp.
    UniformNotifier.active_notfiiers.out_of_channel_notify(notify_message)

    # the notify message will be wrapped by <script type="text/javascript">...</script>,
    # you should append the javascript_str at the bottom of http response body.
    # for more information, please check https://github.com/flyerhzm/bullet/blob/master/lib/bullet/rack.rb
    responses = []
    UniformNotifier.active_notifiers.each do |notifier|
      responses << notifier.inline_notify(notify_message)
    end
    javascript_str = responses.join("\n")


[0]: https://github.com/flyerhzm/bullet