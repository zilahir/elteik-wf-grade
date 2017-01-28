def color(cssfile):
	list=[]
	with open(cssfile) as f:
		for line in f:
			if "a" in line:
				splittedline=line.split("{")[0].strip()
				if (' ' + splittedline)[-2:] == " a" or "a:" == splittedline[:2]  or ("a:" in splittedline.replace(" ", "") and " a" == splittedline.split(":")[0].rstrip()[-2:]):
					list.append(splittedline)
					for line in f:
						if "color" in line:
							color=line.strip().split(":")[1].split(";")[0].strip()
							list.append(color)
							break
						if "}" in line:
							list.append('nincs szine')
							break
	print(list)
	return list

#color()
