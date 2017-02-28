import re
def getClassNames (file) :
	file = open(file)
	line = file.read().replace('\n', '')
	stringExtract2 = re.findall ( '/(.*?)/', line, re.DOTALL)

	for s in stringExtract2:
		line=line.replace(s, "")
	stringExtract3 = re.findall(r'\{.*?\}',line)
	for s in stringExtract3:
		line=line.replace(s, "|")

	line=line.replace("//", "")
	classnamelist = line.split("|")
	classnamelist.pop()
	classnamelist=map(str.strip,classnamelist)
	#print classnamelist
	return classnamelist
def isCssClassHasKeyValuePair (cssPath, className, Attribute, Value) :

	classnamelist=getClassNames(cssPath)


	#print classnamelist
	haskeyvaluepair="false"

	attrvalue=getAttributeValue(cssPath, className, Attribute)

	if Value in attrvalue.split(","):
		haskeyvaluepair="true"
	else:
		haskeyvaluepair="false"
	#print attrvalue
	print haskeyvaluepair
	return haskeyvaluepair
def getAttributeValue (cssPath, className, Attribute) :

	classnamelist=getClassNames(cssPath)
	print classnamelist
	attrvalue = "nincs"

	with open(cssPath) as f:
		for line in f:
			if className in line.replace("{", "").strip().split(" ") and className in classnamelist:
				concline=line
				for line in f :
					#if "}" not in line:

					if "}" not in line and "}" not in concline:
						concline = concline + line.strip().replace(" ", "")
					else:
						break
				#print concline
				if Attribute+":" in concline:
					list=concline.split(Attribute)
					attrvalue=list[-1:][0].split(";")[0].replace(":", "").replace("}", "").strip()
	print attrvalue
	return attrvalue

def sameValue (cssPath, className, Attribute):
	first = getAttributeValue (cssPath, className, Attribute)
	second = getAttributeValue (cssPath, className+":visited", Attribute)

	#print first
	#print second
	if first == second:
		same = "true"
	else:
		same = "false"

	print same
	return same
