# Osu-mania-Map-Generator

This is a semi-started project. 

There is a simple rhythm game called osu! with a game mode called mania. Osu!Mania is a game much like guitar hero, except it has 1-18 lanes that can be hit. The most popular are 4 and 7 lanes. 
Any user can take any song and generate a "beatmap" for that song, which they would put notes into themselves to match the song/beat. 

The idea was to streamline this process by creating an algorithm that simply generates a map from a simple seed and the song's audio. 

This program will take a empty map with 1 note, the first note of the song, and generate the rest of the map provided the BPM has been correctly implemented by the user. 

This was just a proof of concept. 
Currently this program is extremely basic and simply creates a random chord of 0-7 notes on each beat until the end of the song, even if there is no song playing. 

ToDo:
	User puts in first and last note and program generates notes between them. 
	Program does not generate random chords but reads the audio file and generates notes based on some heuristic. 
		BONUS: Have these be patterns that are regularly found in other songs, not competely random keymashing. 

