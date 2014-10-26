task :hello, [:message, :some_arg]  => :environment  do |t, args|
  # `args` is a hash-like object created from the 
  # arguments you pass in to the task when it's invoked
  # The keys are set in order from left to right
  # The `with_defaults` helper just sets a default value
  # for a key if it isn't assigned
  args.with_defaults(:message => "Thanks for logging on")
  puts "Hello #{User.first.name}. #{args.message}!"
  puts "The other argument was: #{args[:some_arg]}!"
end