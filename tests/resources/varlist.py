import types
from robot.libraries.BuiltIn import BuiltIn

def GetAllVariableBySuffix (endswith):
    all_vars = BuiltIn().get_variables()
    result = {}
    for var_name, var in all_vars.items():
        #print var_name
        if var_name.endswith(endswith+"}"):
            print var_name
            #print var

def CountFinalPoints ():
    all_vars = BuiltIn().get_variables()
    result = 0
    result = int(result)
    for var_name, var in all_vars.items():
        #print var_name
        if var_name.endswith("Points}"):
            result += int(var)
            #print var
    return result
