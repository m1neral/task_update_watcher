require 'redmine'

Redmine::Plugin.register :task_update_watcher do
  name 'Task Update Watcher plugin'
  author 'Anatoly Ryabov'
  description 'This is a plugin for Redmine, which send POST-request then some field of any issue is updated.'
  version '0.0.1'
  url 'https://github.com/m1neral/task_update_watcher'
  author_url 'https://github.com/m1neral'
end