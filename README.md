# quickstart
Boilerplate for a repo with quickstart supporting `curl | bash` syntax

# Quick Start
- In your repo:
  - Create a file called `setup.sh` at the base of your repo
    - This bash script should do all the work of installing your repo
  - Copy the lines below into your README
  - Replace QS_REPO with your repo url
```bash
QS_REPO=https://github.com/andylytical/quickstart
#QS_GIT_BRANCH=branch_name  #optional - specify a branch other than master
curl https://raw.githubusercontent.com/andylytical/quickstart/master/quickstart.sh | bash
```

# Example Usage
```bash
QS_REPO=https://github.com/andylytical/quickstart
#QS_GIT_BRANCH=branch_name  #optional - specify a branch other than master
curl https://raw.githubusercontent.com/andylytical/quickstart/master/quickstart.sh | bash
```
- Copy/paste the above lines in your Bash terminal window
- Expected output:
```
Hello from ...
```
