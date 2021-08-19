'use strict';

const fs = require('fs');
const path = require('path');
const JSON = require('json5');
const peg = require("pegjs");

const rootDir = '../Loungeware';
const yypLocation = 'Loungeware.yyp';

const pegExpression = fs.readFileSync(path.join(__dirname, 'extractConfig.peg')).toString();
const extractConfigParser = peg.generate(pegExpression);

function loadYy(filePath) {
  return JSON.parse(fs.readFileSync(path.join(rootDir, filePath)));
}

function extractMetadataScripts(yypData) {
  // Find scripts that end in _metadata
  console.log("Finding metadata scripts");
  const resources = yypData.resources.filter(item => {
    if (item.id.name.startsWith('___')) return false;
    if (item.id.name.startsWith('example_')) return false;
    if (item.id.path.startsWith('scripts/') && item.id.name.endsWith('_metadata')) {
      console.log(`...Found ${item.id.name}`);
      return true;
    }
    return false;
  }).map(item => item.id.path.replace('.yy', '.gml'));
  console.log(`Found ${resources.length} metadata scripts\n`);
  return resources;
}

function findResourceYy(resourceName, yypData) {
  const resource = yypData.resources.filter(item => item.id.name == resourceName);
  if (resource) return resource[0].id.path;
  return null;
}

function removeComments(gml) {
  gml = gml.replace(/\/\/(.*)$/gm, "");
  gml = gml.replace(/\/\*(.*)\*\//gms, "");
  return gml;
}

function extractConfigJsonFromGml(scriptPaths) {
  console.log("Parsing config from GML");
  const games = scriptPaths.map(scriptPath => {
    const gml = removeComments(fs.readFileSync(path.join(rootDir, scriptPath)).toString());
    let config;
    try {
      config = extractConfigParser.parse(gml);
      console.log(`...Parsed ${config.length} configs from ${scriptPath}`);
    } catch(err) {
      console.error(`...Parse error in ${scriptPath}`);
      console.log(gml)
      return [];
    }
    return config;
  }).flat();

  const enabled = games.filter(game => game.config.is_enabled === undefined || game.config.is_enabled === true);

  console.log(`Parsed ${games.length} config from GML, ${enabled.length} were enabled\n`);
  return enabled;
}

function copyLabelImages(games, yypData) {
  console.log("Copying label images");
  games.map(game => {
    const resourcePath = findResourceYy(game.config.cartridge_label, yypData);
    if (resourcePath) {
      const yy = loadYy(resourcePath);
      const frameId = yy.frames[0].compositeImage.FrameId.name;
      const imagePath = path.join(rootDir, path.dirname(resourcePath), `${frameId}.png`);
      const targetPath = path.join("src", "assets", "games", `${game.name}.png`);
      fs.copyFileSync(imagePath, targetPath);
      console.log(`...Copied label image for ${game.name}`)
    } else {
      console.error(`...Could not get label image for ${game.name}`)
    }
  })
  console.log("Copied label images\n");
}

function outputManifest(games) {
  const numGames = games.length;
  const numContributors = [...new Set(games.map(game => game.config.credits).flat())].length;
  const code = `export const games = ${JSON.stringify(games, null, 2)};
export const numGames = ${numGames};
export const numContributors = ${numContributors};
`;
  fs.writeFileSync(path.join("src", "common", "gamesList.ts"), code);
  console.log(`Generated gamesList.ts file, with ${numGames} games and ${numContributors} contributors`);
}

const yypData = loadYy(yypLocation);
const scripts = extractMetadataScripts(yypData);
const games = extractConfigJsonFromGml(scripts);
copyLabelImages(games, yypData);
outputManifest(games);

