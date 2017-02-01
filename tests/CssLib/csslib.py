def IsCssClassHasKeyValuePair (cssPath, className, Attribute, Value) :
	haskeyvaluepair="false"
	with open(cssPath) as f:
		for line in f:
			if className in line:
				#print line
				concline=''
				for line in f :
					concline = concline + line.strip().replace(" ", "")
					if "}" in line:
						break
				print concline
				if Attribute+":" in concline:
					list=concline.split(Attribute)
					#print list
					attrvalue=list[-1:][0].split(";")[0].replace(":", "").replace("}", "")
					#print attrvalue
					if attrvalue == Value:
						haskeyvaluepair="true"
					else:
						haskeyvaluepair="false"
	#print haskeyvaluepair
	return haskeyvaluepair
