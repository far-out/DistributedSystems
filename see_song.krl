ruleset see_songs {
	meta {
		name "See Songs"
		description "Part 1.2"
		author "Travis Hendershot"
		logging on
		sharing on
	}
	
	rule songs {
		select when echo message input "(.*)" msg_type "song" setting(in) 
		send_directive("sing")
			with song = in;
		always {
			raise explicit event sung
				with song = in;
		}
	}
	
	rule find_hymn {
		select when explicit sung song re/.*god.*/i
		always {
			raise explicit event found_hymn 
				with hymn = song;
		}
	}
}

