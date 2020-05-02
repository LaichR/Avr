import sys, pathlib, traceback

p = pathlib.Path(__file__)

#these paths will be used in all actions
sys.path.append(r'C:\Users\rolfl\Documents\GIBZ\py')
sys.path.append(str(p.parent.parent / "PyScripts"))


import StudentsInfo
import CheckoutGitRepo

ProjectsRoot = r"e:\M242"
schuelerInfo = r"C:\Users\rolfl\OneDrive - GIBZ\M242\Semester2020\SchuelerInfo.xlsx"

students = StudentsInfo.Open(schuelerInfo)

noGithubRepo ="""
Hallo zusammen,
Ich habe von ihnen noch keine Angaben zum Github-Repository erhalten
"""

for s in students.Filter(lambda x: x.GithubRepo != None):
    try:
        CheckoutGitRepo.GitCloneOrUpdateRepo(ProjectsRoot, s.NameToIdentifier(), "M242", s.GithubRepo )
    except:
        print("failed to clone of Update repo of", s.Name)
        traceback.print_exc()
