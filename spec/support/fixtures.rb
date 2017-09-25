module Fixtures
  def load_fixture(filename)
    File.read(File.join(fixture_root, filename))
  end

  def fixture_root
    File.expand_path('../fixtures', __dir__)
  end
end
