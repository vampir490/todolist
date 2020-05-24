<h1 align="center">ToDo List</h1>

A **Ruby on Rails** application to save, update, complete tasks. This is a simple ToDo List as part of sample task with the following requirements:

* Users can view their todo list
* Users can add, remove, modify and delete entries
* Each todo entry includes a single line of text, due date and priority.
* Users can assign priorities and due dates to the entries.
* Users can sort todo lists using due date and priority.
* Users can mark an entry as completed.
* RESTful API which will allow a third-party application to trigger actions on the app.
* Authentication and authorization service for both the app and the API.
* You should be able to create users in the system via an interface.

## Versions used
* Ruby 2.6.4
* Rails 5.2.4

## Installation
To use the code:
1. Download the repository using the [instruction](https://help.github.com/en/articles/cloning-a-repository).
2. In the command line go to the directory with the files downloaded.
3. Install required gems. To do that:
   1. Check if the bundler is installed with the command `gem list bundler`
      * If it is not installed - installed it with the command `gem install bundler`.
      * If bundler is already installed, that is perfect. Go to the next step.
   2. In the directory with the game, to install all necessary gems run `bundle`
4. To run migrations: 
```console
bundle exec rake db:migrate
```
**It is important** to use `bundle exec` to make the necessary versions of gems to be used.
