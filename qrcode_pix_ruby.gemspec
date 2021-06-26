# frozen_string_literal: true

require_relative 'lib/qrcode_pix_ruby/version'

Gem::Specification.new do |spec|
  spec.name                        = 'qrcode_pix_ruby'
  spec.version                     = QrcodePixRuby::VERSION
  spec.authors                     = ['Pedro Furtado', 'Marcio de Jesus', 'William Radi', 'Leonardo Comar']
  spec.email                       = ['pedro.felipe.azevedo.furtado@gmail.com', 'marciodejesusrj@gmail.com', 'williamw@lbv.org.br', 'lfcomar@lbv.org.br']
  spec.summary                     = 'Ruby gem for Qrcode generation of Pix (Pagamento Instantâneo Brasileiro - Banco Central do Brasil)'
  spec.description                 = 'Ruby gem for Qrcode generation of Pix (Pagamento Instantâneo Brasileiro - Banco Central do Brasil)'
  spec.homepage                    = 'https://github.com/pedrofurtado/qrcode_pix_ruby'
  spec.license                     = 'MIT'
  spec.metadata['homepage_uri']    = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  spec.metadata['changelog_uri']   = "#{spec.homepage}/CHANGELOG.md"
  spec.required_ruby_version       = '>= 2.3.0'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rqrcode'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
end
