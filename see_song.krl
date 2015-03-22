ruleset see_songs {
	meta {
		name "See Songs"
		description "Part 1.2"
		author "Travis Hendershot"
		logging on
		sharing on
	}
	
	rule songs {
		select when echo message input "(.*)" setting(in)
		send_directive("sing")
			with song = in;
	}
}