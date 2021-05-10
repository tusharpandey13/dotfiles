for x in range(1, 2):
	f = open(str(x), 'w')
	for y in range(1, 11):
		#f.write("http://mc2.dl3enter.in/files/serial/Dexter/s%0.2d/Dexter.S%0.2dE%0.2d.480p.DL.mkv\n" % (x, x, y))
		#http://mc2.dl3enter.in/files/serial/Mr%20Robot/s01/720/Mr.Robot.S01E01.720p.DL.mkv
		#f.write("http://mc2.dl3enter.in/files/serial/Mr%20Robot/s{}/720/Mr.Robot.S{}E{}.720p.DL.mkv\n".format(x, x, y))
		#http://dl3.melimedia.net/mersad/serial/Stranger%20Things/s01/Stranger.Things.S01E01.480p.WEBRip.x264_MeliMedia.INFO.mkv
		#http://dl.my-film.in/serial/The%20Wire/Season%201%20-%20720p%20x265%20BluRay%20/The.Wire.S01E01.720p.BluRay.2CH.x265.HEVC-[My-Film].mkv
		f.write("http://dl3.melimedia.net/mersad/serial/Stranger%20Things/s01/720/Stranger.Things.S01E{}.480p.WEBRip.x264_MeliMedia.INFO.mkv\n".format(y))
		