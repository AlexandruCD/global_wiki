Redmine::Plugin.register :global_wiki do
  name 'Global Wiki plugin'
  author 'Alexandru Creangă'
  description 'This plugin allows Home page to display a project wiki we choose. It takes in account permissions the current user has for the choosen project'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'https://assist-software.net/team/alexandru-creanga'

  settings :default => {'project' => 'default'}, :partial => 'settings/wiki_settings'
end

Rails.configuration.to_prepare do
  ApplicationHelper.send(:include, ::GlobalWikiHelper)
end

require 'global_wiki/hooks.rb'