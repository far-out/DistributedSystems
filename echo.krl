ruleset echo {
	meta {
		name "Echo"
		description "Part 1"
		author "Travis Hendershot"
		logging on
		sharing on
	}
	
	rule hello {
		select when echo hello
		send_directive("say") with
			something = "Hello World";
	}
	
	rule message {
		select when echo message input "(.*)" setting(in)
		send_directive("say") with
			something = in;
	}
}