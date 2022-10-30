Домашнее задание к занятию «2.3. Ветвления в Git»

Commit history:

git log --graph --all --oneline
*   aa7f3a9 (HEAD -> main, origin/main, origin/HEAD) Merge branch 'git-rebase' into main
|\
| *   59d710e (origin/git-rebase) Merge branch 'git-merge'
| |\
* | \   2d9a480 Merge branch 'git-merge'
| |/ /
|/| /
| |/
| * 20f08b3 (origin/git-merge, git-merge) merge: use shift
| * 6513290 merge: @ instead *
* | 4e93bc4 changes in rebase.sh
|/
| * 87e1beb (git-rebase) git-rebase 2
| * cd8afb8 git-rebase 1
|/
* 15d84d1 prepare for merge and rebase
* 0f70c06 (tag: v0.1, tag: v0.0) Moved and deleted
| * 8fb40e2 (origin/fix) New commit via IDE + folders with img from 1st task
| * fa88d55 +1 line in README.md
|/
* 2ed3b52 Prepare to delete and move
* b06b5a1 Added gitignore
* fbca85a First commit
* f522833 Initial commit

Last code that was used for rebase:

andrey@FBRLHDM0575:~/devops-netology$ git log --oneline --graph --all
*   2d9a480 (HEAD -> main, origin/main, origin/HEAD) Merge branch 'git-merge'
|\
| * 20f08b3 (origin/git-merge) merge: use shift
| * 6513290 merge: @ instead *
* | 4e93bc4 changes in rebase.sh
|/
| * 87e1beb (origin/git-rebase) git-rebase 2
| * cd8afb8 git-rebase 1
|/
* 15d84d1 prepare for merge and rebase
* 0f70c06 (tag: v0.1, tag: v0.0) Moved and deleted
| * 8fb40e2 (origin/fix) New commit via IDE + folders with img from 1st task
| * fa88d55 +1 line in README.md
|/
* 2ed3b52 Prepare to delete and move
* b06b5a1 Added gitignore
* fbca85a First commit
* f522833 Initial commit
andrey@FBRLHDM0575:~/devops-netology$ git checkout git-rebase
Branch 'git-rebase' set up to track remote branch 'git-rebase' from 'origin'.
Switched to a new branch 'git-rebase'
andrey@FBRLHDM0575:~/devops-netology$ git pull
Already up to date.
andrey@FBRLHDM0575:~/devops-netology$ git status
On branch git-rebase
Your branch is up to date with 'origin/git-rebase'.

nothing to commit, working tree clean
andrey@FBRLHDM0575:~/devops-netology$ git rebase -i main
error: could not parse '87e1beb git-rebase 2
'
error: invalid line 2: fixup pick 87e1beb git-rebase 2
You can fix this with 'git rebase --edit-todo' and then run 'git rebase --continue'.
Or you can abort the rebase with 'git rebase --abort'.
andrey@FBRLHDM0575:~/devops-netology$ git rebase --edit-todo
error: could not parse '87e1beb git-rebase 2
'
error: invalid line 2: fixup pick 87e1beb git-rebase 2
andrey@FBRLHDM0575:~/devops-netology$ git rebase --edit-todo
andrey@FBRLHDM0575:~/devops-netology$ git rebase --edit-todo
andrey@FBRLHDM0575:~/devops-netology$ git rebase --edit-todo
andrey@FBRLHDM0575:~/devops-netology$ git rebase --continue
Auto-merging branching/rebase.sh
CONFLICT (content): Merge conflict in branching/rebase.sh
error: could not apply cd8afb8... git-rebase 1
Resolve all conflicts manually, mark them as resolved with
"git add/rm <conflicted_files>", then run "git rebase --continue".
You can instead skip this commit: run "git rebase --skip".
To abort and get back to the state before "git rebase", run "git rebase --abort".
Could not apply cd8afb8... git-rebase 1
andrey@FBRLHDM0575:~/devops-netology$ ls
README.md  branching  has_been_moved.txt  terraform
andrey@FBRLHDM0575:~/devops-netology$ cd branching/
andrey@FBRLHDM0575:~/devops-netology/branching$ ls
merge.sh  rebase.sh
andrey@FBRLHDM0575:~/devops-netology/branching$ vi rebase.sh
andrey@FBRLHDM0575:~/devops-netology/branching$ git add rebase.sh
andrey@FBRLHDM0575:~/devops-netology/branching$ git rebase --continue
Auto-merging branching/rebase.sh
CONFLICT (content): Merge conflict in branching/rebase.sh
error: could not apply 87e1beb... git-rebase 2
Resolve all conflicts manually, mark them as resolved with
"git add/rm <conflicted_files>", then run "git rebase --continue".
You can instead skip this commit: run "git rebase --skip".
To abort and get back to the state before "git rebase", run "git rebase --abort".
Could not apply 87e1beb... git-rebase 2
andrey@FBRLHDM0575:~/devops-netology/branching$ vi rebase.sh
andrey@FBRLHDM0575:~/devops-netology/branching$ git add rebase.sh
andrey@FBRLHDM0575:~/devops-netology/branching$ git rebase --continue
[detached HEAD 59d710e] Merge branch 'git-merge'
 Date: Thu Aug 11 15:57:53 2022 +0300
Successfully rebased and updated refs/heads/git-rebase.
andrey@FBRLHDM0575:~/devops-netology/branching$ git push -u origin git-rebase
Username for 'https://github.com': ercuru
Password for 'https://ercuru@github.com':
remote: Invalid username or password.
fatal: Authentication failed for 'https://github.com/ercuru/devops-netology.git/'
andrey@FBRLHDM0575:~/devops-netology/branching$ git push
Username for 'https://github.com': ercuru
Password for 'https://ercuru@github.com':
remote: Invalid username or password.
fatal: Authentication failed for 'https://github.com/ercuru/devops-netology.git/'
andrey@FBRLHDM0575:~/devops-netology/branching$ git push
Username for 'https://github.com': ercuru
Password for 'https://ercuru@github.com':
To https://github.com/ercuru/devops-netology.git
 ! [rejected]        git-rebase -> git-rebase (non-fast-forward)
error: failed to push some refs to 'https://github.com/ercuru/devops-netology.git'
hint: Updates were rejected because the tip of your current branch is behind
hint: its remote counterpart. Integrate the remote changes (e.g.
hint: 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
andrey@FBRLHDM0575:~/devops-netology/branching$ git push -u origin git-rebase -f
Username for 'https://github.com': ercuru
Password for 'https://ercuru@github.com':
Enumerating objects: 10, done.
Counting objects: 100% (10/10), done.
Delta compression using up to 4 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 423 bytes | 423.00 KiB/s, done.
Total 4 (delta 2), reused 0 (delta 0)
remote: Resolving deltas: 100% (2/2), completed with 2 local objects.
To https://github.com/ercuru/devops-netology.git
 + 87e1beb...59d710e git-rebase -> git-rebase (forced update)
Branch 'git-rebase' set up to track remote branch 'git-rebase' from 'origin'.
andrey@FBRLHDM0575:~/devops-netology/branching$ git status
On branch git-rebase
Your branch is up to date with 'origin/git-rebase'.

nothing to commit, working tree clean
andrey@FBRLHDM0575:~/devops-netology/branching$ git checkout main
Switched to branch 'main'
Your branch is up to date with 'origin/main'.
andrey@FBRLHDM0575:~/devops-netology/branching$ git merge git-rebase
Merge made by the 'recursive' strategy.
 branching/rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
andrey@FBRLHDM0575:~/devops-netology/branching$






----------------------------------------
First line

Will be ignored for commit from directory terraform:
- all files with extensions *.tfstate, *.tfvars
- files: all _override.tf, _override.tf.json; .terraformrc, terraform.rc, override.tf.json, override.tf, crash.log;
- all files with extention log and starts with carsh
- all sub dirs .terraform and it contents
