# Week 2 

## Review
Last week, we set up Rstudio to use ssh keys and git. We cloned a shared github repository, edited, and pushed. 
We briefly talked about Markdown, and edited a python script.  Then we got stuck with a merge conflict!


## Git review
* Open Rstudio, switch to the carpen-group project.
* Look at files in git pane - M = modified, A = added
* Commit your changes before you proceed: 

    * *Git Docs Warning* "Running git merge with non-trivial uncommitted changes is discouraged: while possible, it may leave you in a state that is hard to back out of in the case of a conflict."

* Click on "More" (gear icon), select "Shell".
* If you had trouble merging, use "git merge --abort"

## Python
* In Rstudio, make a new project with git URL https://github.com/ncsu-sw-carpen/carpen-group.wiki
* Use the wiki as a subdirectory of carpen-group 
* Make sure you have the file HW02.md, and inspect the path (files pane).
* Now switch back to the carpen-group project and edit wk02.re.py
* Run from terminal with: ```python wk02.re.py```


## Python Refs
* File handling: https://docs.python.org/2/tutorial/inputoutput.html
* Regular expressions: https://docs.python.org/2/library/re.html
