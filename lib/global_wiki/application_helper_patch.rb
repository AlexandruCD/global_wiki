module GlobalWiki
  module Patches
    module ApplicationHelperPatch
      def self.included(base)
        base.class_eval do
          unloadable

          def custom_wiki?

            project_id_from_settings = Setting.plugin_global_wiki["project"]

            project_id_from_settings == "default" ? false : true
          end

          def is_user_allowed?
            project_id_from_settings = Setting.plugin_global_wiki["project"]

            return false if project_id_from_settings == "default"

            project = Project.find(project_id_from_settings)

            return User.current.allowed_to?(:view_project, project)
          end

          def project_wiki_content
            project_id_from_settings = Setting.plugin_global_wiki["project"]

            project = Project.find(project_id_from_settings)

            project.wiki.pages.where(title: project.wiki.start_page).first.content.text rescue ""
          end

          def global_project
            project_id_from_settings = Setting.plugin_global_wiki["project"]

            project_id_from_settings == "default" ? nil : Project.find(project_id_from_settings)
          end
        end
      end
    end
  end
end

unless ApplicationHelper.included_modules.include?(GlobalWiki::Patches::ApplicationHelperPatch)
  ApplicationHelper.send(:include, GlobalWiki::Patches::ApplicationHelperPatch)
end
