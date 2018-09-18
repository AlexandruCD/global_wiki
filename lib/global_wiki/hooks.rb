module GlobalWiki
  class Hooks < Redmine::Hook::ViewListener
    render_on(:view_welcome_index_left, :partial => '/global_wiki_page', :layout => false)
  end
end
