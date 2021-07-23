# frozen_string_literal: true

require 'pathname'

def file_fixture(fixture_name)
  file_fixture_path = 'spec/fixtures/'
  Pathname.new(File.join(file_fixture_path, fixture_name))
end
