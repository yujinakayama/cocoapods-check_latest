# coding: utf-8

module Pod
  class Command
    class CheckLatest < Command
      self.summary = 'Check if the latest version of a pod is up to date'
      self.arguments = '[NAME]'

      def initialize(argv)
        @name = argv.shift_argument
        super
      end

      def validate!
        super
        help!('A pod name is required.') unless @name
      end

      def run
        sets = SourcesManager.search_by_name(@name.strip)
        sets.each do |set|
          show_pod(set)
        end
      end

      def show_pod(set)
        UI.title("\n-> #{set.name}".green, '', 1) do
          UI.labeled 'Homepage', set.specification.homepage

          latest_pod_version = set.highest_version.to_s
          UI.labeled 'Latest pod version', latest_pod_version

          github_url = github_url(set)

          if github_url
            latest_version_in_original_repo = latest_version_in_repo(github_url)
            UI.labeled 'Latest version in original repo', latest_version_in_original_repo
            unless latest_pod_version == latest_version_in_original_repo
              UI.puts_indented 'Outdated!'.yellow
            end
          else
            UI.warn 'Only GitHub source repository is supported.'
          end
        end
      end

      def github_url(set)
        git_url = set.specification.source[:git]
        return nil unless git_url
        return nil unless git_url.include?('github.com/')
        git_url
      end

      def latest_version_in_repo(git_url)
        tags = github_tags(git_url)
        versions_from_tags(tags).sort.last
      end

      def github_tags(git_url)
        GitHub.tags(git_url).map { |hash| hash['name'] }
      end

      def versions_from_tags(tags)
        tags.map do |tag|
          normalized_tag = tag.strip.sub(/\Av\D*/i, '')
          if Version.correct?(normalized_tag)
            normalized_tag
          else
            nil
          end
        end.compact
      end
    end
  end
end
