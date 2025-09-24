# quickstart
Boilerplate for a repo with quickstart supporting `curl | bash` syntax

# Quick Start
- In your repo:
  - Create a file called `setup.sh` at the base of your repo
    - This bash script should do all the work of installing your repo
    - Ensure setup.sh is executable
  - Copy these lines into your README:
  ```bash
  export QS_GIT_REPO=YOUR_GITHUB_REPO_URL
  curl https://raw.githubusercontent.com/andylytical/quickstart/main/quickstart.sh | bash
  ```
  - Replace YOUR_GITHUB_REPO_URL with your repo url

## Specifying a branch
- Do one of the following
  - Option 1: `export QS_GIT_REPO=YOUR_GITHUB_REPO_URL_INCLUDING_BRANCH`
  - Option 2: `export QS_GIT_BRANCH=BRANCH_NAME`
- NOTE: If both are specified, QS_GIT_BRANCH will be used.

# Examples
### Install from main
```bash
export QS_GIT_REPO=https://github.com/andylytical/quickstart
curl https://raw.githubusercontent.com/andylytical/quickstart/main/quickstart.sh | bash
```

### Install from branch (Option 1)
```bash
export
QS_GIT_REPO=https://github.com/andylytical/quickstart/tree/a/test/branch
curl https://raw.githubusercontent.com/andylytical/quickstart/main/quickstart.sh | bash
```

### Install from branch (Option 2)
```bash
export QS_GIT_REPO=https://github.com/andylytical/quickstart
export QS_GIT_BRANCH=a/test/branch
curl https://raw.githubusercontent.com/andylytical/quickstart/main/quickstart.sh | bash
```

# Trying the example
Pick any example from above and run it in your Bash terminal window.

Expected output:
```
Hello from '/tmp/tmp.81DzXvvQ6s/setup.sh'
Install dir: '/home/aloftus/junk'
Nothing else to do.
```
