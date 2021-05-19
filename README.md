## Bowling score app

Simple command line program that takes an .txt file with pinfalls and transform to scores and propper format.

## Prerequisites

- Install git
- Install ruby
- Install gem bundler 

### Install & project

- Clone the project with the following command `git clone https://github.com/cardotrejos/bowling-scores.git`
- Enter inside the project folder
- Run `bundle install`
- Run `ruby main.rb resources/example.txt` 
- See the results on your terminal

### Run test suite

- Enter inside the project folder
- Run `rspec`

### Current features and TODO

This project has git-hooks, I set up the pre-commit hook to check the committed code with rubocop, if the code doesn't follow the correct standards it will prompt a message about that offenses. Here is the code:

```bash
#!/usr/bin/env ruby

ADDED_OR_MODIFIED = /^\s*(A|AM|M)/.freeze

changed_files = `git status --porcelain`.split(/\n/)
unstaged_files = `git ls-files -m`.split(/\n/)

changed_files = changed_files.select { |f| f =~ ADDED_OR_MODIFIED }
changed_files = changed_files.map { |f| f.split(" ")[1] }

changed_files -= (unstaged_files - changed_files)

changed_files = changed_files.select { |file_name| File.extname(file_name) == ".rb" }
changed_files = changed_files.join(" ")

exit(0) if changed_files.empty?

success = system(%(
  rubocop #{changed_files}
))

STDIN.reopen('/dev/tty')

if success == false
  puts "Would you like to continue press 'any key' or 'n/N' to halt? "
  exit(1) if %w(N n).include?(gets.chomp)
end
```
#### TODO

This project can be better, applying clean code practices, some SOLID principles, resolving some offenses about long methods and assigment branch condition.
