worker_processes 8 # amount of unicorn workers to spin up
timeout 15         # restarts workers that hang for 30 seconds
preload_app true   # reduce mem footprint
