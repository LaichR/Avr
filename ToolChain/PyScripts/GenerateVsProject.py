import pathlib, os, sys, string, uuid

srcItemTemplate = """
    <ClCompile Include="$filePath"/>"""

def GenerateVsTemplate( project, projectRoot, toolsRoot, avrGcc ):
    destPath = pathlib.Path(projectRoot);
    destFile = destPath / "{0}.vcxproj".format(project)
    sources = [ x.name for x in destPath.iterdir() if x.suffix == ".c"]
    srcItemTemplateInstance = string.Template(srcItemTemplate)
    clCompileList = "".join( map( lambda x: srcItemTemplateInstance.safe_substitute(filePath=str(x)), sources))
    templatePath = pathlib.Path(toolsRoot) / "VsProjectTemplate" / "VsProjectTemplate.vcxproj"
    with open( str(templatePath), "r") as fr:
        data = fr.read()
        t = string.Template(data)
        proj = t.safe_substitute(project = project, sources = clCompileList, avrGcc = avrGcc, uuid_ = str(uuid.uuid1()))
        with open(str(pathlib.Path(destFile)), "w") as fw:
            fw.write(proj)


if __name__ == '__main__':
    project = os.environ['Project']
    projectRoot = os.environ['ProjectRoot']
    avrGcc = os.environ['AvrGcc']
    toolsRoot =  os.environ['ToolsRoot']
    assert( project )
    assert( projectRoot )
    assert( avrGcc )
    assert( toolsRoot )
    GenerateVsTemplate( project, projectRoot, toolsRoot, avrGcc )
