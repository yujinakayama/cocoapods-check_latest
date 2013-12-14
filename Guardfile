# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard :rspec, all_after_pass: true, all_on_start: true, cmd: 'bundle exec rspec' do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})        { |m| "spec/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')     { 'spec' }
  watch(%r{^spec/support/.+\.rb$}) { 'spec' }
end

guard :rubocop do
  watch(%r{.+\.rb$})
  watch(%r{/?(?:Rake|Gem|Guard)file$})
  watch(%r{\.gemspec$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end
