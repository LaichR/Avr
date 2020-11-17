import os, sys, pathlib, re, itertools, functools, json

#link to dot net libraries
p = pathlib.Path(__file__)

def ShowAndCheckVariable( variable, isPath ):
    if not variable in os.environ:
        print ( "environment variable {0} not set".format(variable))
    
    value = os.environ[variable]
    print( "{0} defined as \t'{1}'".format(variable, value))
    if isPath:
        isValidPath = "ok"
        if not os.path.exists(value):
           isValidPath = "not ok"
        print( "\t\t-- ? {1}".format(value, isValidPath ))
        
def CheckDotnetAccess():
    print( "Dot Net: importing clr" )
    import clr
    path = pathlib.Path(os.environ['DotNetLib'])
    sys.path.append(str(path))
    clangPath = path / "Clang.dll"
    if not os.path.exists( clangPath ):
        print ( "Dot Net: file {0} not available".format(clangPath))
        return
    try:
        print("Dot Net: adding reference to Clang.dll")
        clr.AddReference("Clang")
        import Clang
    except:
        print ("Dot Net: failed to add reference to Clang.dll" )
        return
    print ("Dot Net: Library Clang.dll successfully loaded")
            


if __name__ == "__main__":
    print ("show environment:")
    print ("*****************")
    print ("current python version = {0}".format(sys.version))
    ShowAndCheckVariable('ProjectRoot', True)
    ShowAndCheckVariable('ToolsRoot', True)
    ShowAndCheckVariable('AvrGcc', True)
    ShowAndCheckVariable('AvrDude', True)
    ShowAndCheckVariable('DotNetLib', True)
    print ("current path = {0}".format(str(p)))
    CheckDotnetAccess()