# Run me with:
#
#   $ watchr specs.watchr

# --------------------------------------------------
# Convenience Methods
# --------------------------------------------------

def run(files_to_run)
  command = "rspec #{files_to_run}"
  puts("Running: #{command}")
  system(command)
  no_int_for_you
end

def run_all_specs
  run('spec/')
end

# --------------------------------------------------
# Watchr Rules
# --------------------------------------------------
watch('(.*)\.rb')   { run_all_specs }

# --------------------------------------------------
# Signal Handling
# --------------------------------------------------

def no_int_for_you
  @sent_an_int = nil
end

Signal.trap 'INT' do
  if @sent_an_int then      
    puts "   A second INT?  Ok, I get the message.  Shutting down now."
    exit
  else
    puts "   Did you just send me an INT? Ugh.  I'll quit for real if you do it again."
    @sent_an_int = true
    Kernel.sleep 1.5
    run_all_specs
  end
end

