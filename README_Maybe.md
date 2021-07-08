# Loungeware
A Warioware-style collaboration game

## Getting Started 

### 0) Prerequisites 
- GMS2 License
- Github Account
- Basic understanding of GIT ( stage, commit, pull, push, pull request ) 

### 1) Fork the project 

![Click "Fork" in top right](https://i.imgur.com/5HMmWU1.png)

### 2) Clone your fork 
To begin dev you must create your own fork. This is done on github. When you are finished  clone your fork to your local disk.

```
git clone https://github.com/your-name/Loungeware
```

### 3) Running The Project

You will not have a .yyp file in your folder. Create one
```
./generateProject.bat
```

You may now open the yyp in GMS2

## Submitting your game 

### 0) Close GMS2 
Simply close gms2

### 1) Ensure you're synced with latest 

```
git fetch https://github.com/spacebake/Loungeware
git pull https://github.com/spacebake/Loungeware
```

### 2) Regenerate your YYP file

After syncing with latest the yyp file may need to be rebuild
```
./generateProject.bat
```

You will now have a new YYP file containing your work and latest work. You'd best run the game and make sure everything still works.

### 3) Stage, Commit, and Push your changes 

```
git add .
git commit -m "I Made some changes"
git push 
```

### 4) Create a PR 

Visit *your* repo online and click create pull request. Target the main branch of the *this* repo

![Click create PullRequest](https://i.imgur.com/ZDijdjB.png)


