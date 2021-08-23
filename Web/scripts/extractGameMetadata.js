'use strict';

const fs = require('fs');
const path = require('path');
const JSON = require('json5');
const peg = require('pegjs');

const ROOT_DIR = path.join('..', 'Loungeware');
const YYP_FILE = 'Loungeware.yyp';
const LAROLD_SPRITE_NAME = '___spr_larold_heads';
const TARGET_GAMES_LIST_FILE = path.join('src', 'common', 'gamesList.ts');
const TARGET_LAROLDS_LIST_FILE = path.join('src', 'common', 'laroldsList.ts');
const TARGET_LABELS_DIR = path.join('public', 'static', 'games');
const TARGET_LAROLDS_DIR = path.join('public', 'static', 'larolds');

if (!fs.existsSync(TARGET_LABELS_DIR)) {
  fs.mkdirSync(TARGET_LABELS_DIR);
}

if (!fs.existsSync(TARGET_LAROLDS_DIR)) {
  fs.mkdirSync(TARGET_LAROLDS_DIR);
}

const pegExpression = fs
  .readFileSync(path.join(__dirname, 'extractConfig.peg'))
  .toString();
const extractConfigParser = peg.generate(pegExpression);

/**
 * Loads a YY file as JSON
 * @param {string} filePath path of the YY file
 * @returns {object}
 */
function loadYy(filePath) {
  return JSON.parse(fs.readFileSync(path.join(ROOT_DIR, filePath)));
}

/**
 * Finds scripts that end in _metadata
 * @param {object} yypData YYP file data object
 * @returns {string[]} list of GM script asset namesnames
 */
function extractMetadataScripts(yypData) {
  // Find scripts that end in _metadata
  console.log('Finding metadata scripts');
  const resources = yypData.resources
    .filter((item) => {
      if (item.id.name.startsWith('___')) return false;
      if (item.id.name.startsWith('example_')) return false;
      if (
        item.id.path.startsWith('scripts/') &&
        item.id.name.endsWith('_metadata')
      ) {
        console.log(`...Found ${item.id.name}`);
        return true;
      }
      return false;
    })
    .map((item) => item.id.path.replace('.yy', '.gml'));
  console.log(`Found ${resources.length} metadata scripts\n`);
  return resources;
}

/**
 * Find a resource YY file path for a given resource name in the YYP
 * @param {string} assetName Name of GM asset to find
 * @param {object} yypData YYP file data object
 * @returns {string | null}
 */
function findAssetYy(assetName, yypData) {
  const resource = yypData.resources.filter(
    (item) => item.id.name == assetName
  );
  if (resource) return resource[0].id.path;
  return null;
}

/**
 * Strips single-line and multi-line comments out of GML code
 * @param {string} gml GML code as string
 * @returns {string} cleande GML code
 */
function removeComments(gml) {
  gml = gml.replace(/\/\/(.*)$/gm, '');
  gml = gml.replace(/\/\*(.*)\*\//gms, '');
  return gml;
}

/**
 * Extracts all the microgame configs from list of microgame _metadata gml scripts
 * @param {string[]} scriptPaths List of script resource paths
 * @returns {object[]} List of microgame config objects
 */
function extractConfigJsonFromGml(scriptPaths) {
  console.log('Parsing config from GML');
  const games = scriptPaths
    .map((scriptPath) => {
      const gml = removeComments(
        fs.readFileSync(path.join(ROOT_DIR, scriptPath)).toString()
      );
      let config;
      try {
        config = extractConfigParser.parse(gml);
        console.log(`...Parsed ${config.length} configs from ${scriptPath}`);
      } catch (err) {
        console.error(`...Parse error in ${scriptPath}`);
        console.log(gml);
        return [];
      }
      return config;
    })
    .flat();

  const enabled = games.filter(
    (game) =>
      game.config.is_hidden === undefined || game.config.is_hidden === false
  );

  console.log(
    `Parsed ${games.length} config from GML, ${enabled.length} were enabled\n`
  );
  return enabled;
}

/**
 * Copy all the microgame label image PNG files
 * @param {object[]} games List of microgame config objects
 * @param {object} yypData YYP data object
 */
function copyLabelImages(games, yypData) {
  console.log('Copying label images');
  games.map((game) => {
    const resourcePath = findAssetYy(game.config.cartridge_label, yypData);
    if (resourcePath) {
      const yy = loadYy(resourcePath);
      const frameId = yy.frames[0].compositeImage.FrameId.name;
      const imagePath = path.join(
        ROOT_DIR,
        path.dirname(resourcePath),
        `${frameId}.png`
      );
      const targetPath = path.join(TARGET_LABELS_DIR, `${game.name}.png`);
      fs.copyFileSync(imagePath, targetPath);
      console.log(`...Copied label image for ${game.name}`);
    } else {
      console.error(`...Could not get label image for ${game.name}`);
    }
  });
  console.log('Copied label images\n');
}

/**
 * Output the game config objects as an importable TS file
 * @param {object[]} games List of game config objects
 */
function outputManifest(games) {
  // todo, validate unique author ids
  games.forEach((game) => {
    game.author_slug = game.config.author_id
      ? game.config.author_id
      : game.name.split('_')[0];

    game.author_slug.replace(/_/g, '-');
    game.game_slug = game.name
      .replace(/_/g, '-')
      .replace(`${game.author_slug}-`, '');
  });
  const numGames = games.length;
  const numContributors = [
    ...new Set(games.map((game) => game.config.credits).flat()),
  ].length;
  const code = `export const games = ${JSON.stringify(games, null, 2)};
export const numGames = ${numGames};
export const numContributors = ${numContributors};
`;
  fs.writeFileSync(TARGET_GAMES_LIST_FILE, code);
  console.log(
    `Generated gamesList.ts file, with ${numGames} games and ${numContributors} contributors\n`
  );
}

/**
 * Copies Larold PNG images
 * @param {object} yypData YYP data object
 * @returns {string[]} List of larold names
 */
function copyLaroldImages(yypData) {
  console.log('Copying Larold images');
  const resourcePath = findAssetYy(LAROLD_SPRITE_NAME, yypData);
  const yy = loadYy(resourcePath);

  const imagePaths = yy.frames.map((frame) => {
    const frameId = frame.compositeImage.FrameId.name;
    return path.join(ROOT_DIR, path.dirname(resourcePath), `${frameId}.png`);
  });

  // TODO: fetch larold image names
  const laroldNames = imagePaths.map((imagePath, idx) => {
    const imageName = `larold_${idx}.png`;
    const targetPath = path.join(TARGET_LAROLDS_DIR, imageName);
    fs.copyFileSync(imagePath, targetPath);
    return imageName;
  });

  console.log(`Copied ${laroldNames.length} Larold images\n`);
  return laroldNames;
}

/**
 * Output the list of Larolds as an importable TS file
 * @param {string[]} laroldNames List of larold names
 */
function outputLaroldList(laroldNames) {
  const code = `export const larolds = ${JSON.stringify(laroldNames, null, 2)};
`;
  fs.writeFileSync(TARGET_LAROLDS_LIST_FILE, code);
  console.log(
    `Generated laroldsList.ts file, with ${laroldNames.length} Larolds\n`
  );
}

/**
 * Script entrypoint
 */
function main() {
  const yypData = loadYy(YYP_FILE);
  const scripts = extractMetadataScripts(yypData);
  const games = extractConfigJsonFromGml(scripts);
  copyLabelImages(games, yypData);
  outputManifest(games);

  const laroldNames = copyLaroldImages(yypData);
  outputLaroldList(laroldNames);
}

if (require.main === module) {
  main();
}
