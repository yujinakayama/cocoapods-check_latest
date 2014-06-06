# coding: utf-8

require 'spec_helper'
require 'cocoapods'
require 'pod/command/check_latest'

module Pod
  class Command
    describe CheckLatest do
      subject(:command) { Pod::Command.parse(argv) }
      let(:argv) { CLAide::ARGV.new(['--no-color', 'check-latest']) }

      before do
        spec_dir = File.expand_path('../../..', __FILE__)
        repos_dir = File.join(spec_dir, 'fixtures/podspec_repos')
        repos_pathname = Pathname.new(repos_dir)
        allow(SourcesManager.config).to receive(:repos_dir).and_return(repos_pathname)
      end

      let(:set) { SourcesManager.search_by_name('GHUnitIOS').first }

      describe '#show_pod' do
        before do
          allow(UI).to receive(:puts)
        end

        context "when the pod's source is not a GitHub repository" do
          before do
            allow(command).to receive(:github_url).and_return(nil)
          end

          it 'does not fetch GitHub tags' do
            expect(command).not_to receive(:latest_version_in_repo)
            command.show_pod(set)
          end

          it 'warns to the user' do
            expect(UI).to receive(:warn).with('Only GitHub source repository is supported.')
            command.show_pod(set)
          end
        end
      end

      describe '#github_url' do
        subject { command.github_url(set) }

        context "when the pod's source is a GitHub repository" do
          it 'returns the URL' do
            is_expected.to eq('https://github.com/gh-unit/gh-unit.git')
          end
        end

        context "when the pod's source is a Git repository but not GitHub one" do
          before do
            allow_any_instance_of(Specification).to receive(:source).and_return(git: 'foo')
          end

          it { is_expected.to be_nil }
        end

        context "when the pod's source is a Subversion repository" do
          before do
            allow_any_instance_of(Specification).to receive(:source).and_return(svn: 'foo')
          end

          it { is_expected.to be_nil }
        end
      end

      describe '#versions_from_tags' do
        subject { command.versions_from_tags(tags) }

        context 'when the passed tags include a non-version tag' do
          let(:tags) { ['0.5.8', 'foo'] }

          it 'excludes the tag' do
            is_expected.to eq(['0.5.8'])
          end
        end

        context 'when the passed tags include a tag prefixed with "v"' do
          let(:tags) { ['0.5.8', 'v0.5.7'] }

          it 'removes the prefix' do
            is_expected.to eq(['0.5.8', '0.5.7'])
          end
        end

        context 'when the passed tags include a tag prefixed with "ver"' do
          let(:tags) { ['0.5.8', 'ver0.5.7'] }

          it 'removes the prefix' do
            is_expected.to eq(['0.5.8', '0.5.7'])
          end
        end

        context 'when the passed tags include a tag with unknown prefix' do
          let(:tags) { ['0.5.8', 'release-0.5.7'] }

          it 'excludes the tag' do
            is_expected.to eq(['0.5.8'])
          end
        end
      end

      describe '#latest_version_in_repo' do
        let(:git_url) { 'https://github.com/gh-unit/gh-unit.git' }

        before do
          allow(command).to receive(:github_tags)
            .with(git_url).and_return(['release-0.3.6', '0.5.8', '0.5.7'])
        end

        it 'returns the latest version in the repository' do
          latest_version = command.latest_version_in_repo(git_url)
          expect(latest_version).to eq('0.5.8')
        end
      end

      describe '#github_tags' do
        let(:git_url) { 'https://github.com/gh-unit/gh-unit.git' }

        let(:data) do
          [
            { 'name' => 'release-0.3.6' },
            { 'name' => '0.5.8' },
            { 'name' => '0.5.7' }
          ]
        end

        before do
          allow(GitHub).to receive(:tags).with(git_url).and_return(data)
        end

        it 'returns an array of tag names' do
          tags = command.github_tags(git_url)
          expect(tags).to eq(['release-0.3.6', '0.5.8', '0.5.7'])
        end
      end
    end
  end
end
