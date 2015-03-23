ruleset song_store {
	meta {
		name "Song Store"
		description "Part 3"
		author "Travis Hendershot"
		logging on
		sharing on
		provides songs, hymns, secular_music
	}
	
	global {
		songs = function(){ent:songs.join(", ")}
		hymns = function(){ent:hymns.join(", ")}
		secular_music = function(){ent:songs.filter(function(x){not x.match(re/.*god.*/i)}).join(", ")}
	}
	
	rule collect_songs {
		select when explicit sung song "(.*)" setting(in)
		pre {
			old_songs = ent:songs || [];
			new_song = [time:now() + " " + in];
			songs = old_songs.append(new_song);
		}
		always{
			set ent:songs songs;
		}
	}
	
	rule collect_hymns {
		select when explicit found_hymn hymn "(.*)" setting (in)
		pre {
			old_hymns = ent:hymns || [];
			new_hymn = [time:now() + " " + in];
			hymns = old_hymns.append(new_hymn);
		}
		always{
			set ent:hymns hymns;
		}
	}
	
	rule clear_songs {
		select when song clear_all
		always {
			clear ent:songs;
			clear ent:hymns;
		}
	}
}