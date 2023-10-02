f = open("metafile", "a")
for i in range(60):
 f.write("u" + str(i) + "/COLVAR" + " " + str("{0:.2f}".format(2 + i * 0.05)) + " 1673.6" + "\n")
for i in range(61,121):
 f.write("u" + str(i) + "/COLVAR" + " " + str("{0:.2f}".format(5.05 + (i-61) * 0.1)) + " 250" + "\n")
f.close()
