# guard

ignore /.git/

watch(/.*/) do |file, _|
  system "rubocop --auto-correct #{file}"
  system 'rspec'
end
