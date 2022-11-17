
spdl::setup("demoForTest", "warn")      # new logger
spdl::set_pattern("[%n] [%l] %v"); 	# special pattern _without time or pid_ for Rout.save use

spdl::trace("This will not be seen.")
spdl::debug("Neither will this.")
spdl::info("Nor this.")
spdl::warn("But we will see this message")
spdl::warn("Format {} and {} and {}", 42L, 1.23, TRUE)

spdl::set_level("debug")
spdl::trace("This will still not be seen.")
spdl::debug("But this will: {}.", "Yay!!")
spdl::info("And this. {} and {}", 42L, 43)
