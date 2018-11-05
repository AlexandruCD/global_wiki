require 'redmine'
require 'global_wiki/application_helper_patch'
require_dependency 'global_wiki/hooks'

Redmine::Plugin.register :global_wiki do
  name 'Global Wiki plugin'
  author 'Alexandru Creangă'
  description 'This plugin allows Home page to display a project wiki we choose. It takes in account permissions the current user has for the choosen project'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'https://assist-software.net/team/alexandru-creanga'

  settings :default => {'project' => 'default'
                         }, :partial => 'settings/wiki_settings'

  menu :admin_menu, :custom_menu, { :controller => 'custom_links', :action => 'index' }, { :last => true, :caption => :custom_links, :html => { :class => 'icon icon-shared' } }
end


custom_links = CustomLink.all

custom_links.each do |c_link|
  Redmine::MenuManager.map(:top_menu).push c_link.name.to_sym, c_link.url, { :after => c_link.after_which.to_sym, :caption => c_link.name } unless Redmine::MenuManager.map(:top_menu).exists?(c_link.name.to_sym)
end
