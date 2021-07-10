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

### 3) Setup your Microgame

- create a room. All rooms are stored under Microgames/author-name. See the good manners article for naming conventions.
- goto Loungeware/datafiles and create a folder. Usually  the folder is named after your name. This will contain all your configuration files for your many microgames
- create your first game config. Usually this is named after your game + your unique prefix. Check other folders here for examples, and copy and paste example.json for ease
- configure your game config file, and point it towards your room


### 4) (Optional) Set up your test env

By default the game will play all games. To test for your specific game simply create a config.dev.json file. 
- goto `Loungeware/datafiles` and copy `config.example.json`. Create a new file *directly next* to config.example.json called `config.dev.json`
- customise this file, pointing it to your games name. Your game name is whatever game config file you created in step 3. For example `games/n8fl/n8fl_escape1.json` would mean pointing your test key at `n8fl_escape1`

You may now open the yyp in GMS2

## Submitting Your Game

### 1) Stage, Commit, and Push your changes 

```
git add .
git commit -m "I Made some changes"
git push 
```

### 2) Create a PR 

Visit *your* repo online and click create pull request. Target the main branch of the *this* repo

![Click create PullRequest](https://i.imgur.com/ZDijdjB.png)


