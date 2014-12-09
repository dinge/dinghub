# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

desc "Run all tests on an empty db"
task spec: ["test:clean_test_db"] do
  # this prepends the task "test:clean_test_db" to the spec task
  # see http://www.dan-manges.com/blog/modifying-rake-tasks
end
