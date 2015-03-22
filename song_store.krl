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
		select when explicit sung song (.*) setting(in)
		always{
			set ent:songs [] if (ent:songs eq 0)
			ent:songs.append(timestamp + " " + in);
		}
	}
	
	rule collect_hymns {
		select when explicit found_hymn hymn (.*) setting (in)
		always{
			set ent:hymns [] if (ent:hymns eq 0)
			ent:hymns.append(timestamp + " " + in);
		}
	}
	
	rule clear_songs {
		select when song clear
		always {
			clear ent:songs;
			clear ent:hymns;
		}
	}
}