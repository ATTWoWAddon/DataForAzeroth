// script to dynamically generate DataForAzeroth.lua during build
import fs from 'fs';

async function downloadMax() {
    let response = await fetch('https://www.dataforazeroth.com/dynamic/max.json');
    if (response.status !== 200) return 0;

    let json = await response.json();
    if (!json.location) return 0;

    response = await fetch('https://www.dataforazeroth.com' + json.location);
    if (response.status !== 200) return 0;

    json = await response.json();
    return json['completion-score'] || 0;
}

async function downloadLeaderboard() {
    const response = await fetch('https://api.dataforazeroth.com/addon', { headers: { 'Origin': 'www.dataforazeroth.com', 'Accept': 'text/json; charset=iso-8859-1'}});
    if (response.status !== 200) return null;

    const json = await response.json();
    if (!json?.length) return null;

    return json;
}

function generateLua(rows, max) {
    const lua = [
        `local appName, app = ...;`,
        `app.CHARACTER_DATA = {`
    ];

    for (let row of rows) {
        const guid = 'Player-' + row.connectedid + '-' + row.characterid.toString(16).padStart(8, '0').toUpperCase();
        lua.push(`["${guid}"] = { ${row.score}, ${max}, ${row.rank}, 0, 0 },`);
    }

    lua.push('};');
    return lua.join('\n');
}

const rows = await downloadLeaderboard();
const max = await downloadMax();
if (rows && max) {
    const lua = generateLua(rows, max);
    fs.writeFileSync('DataForAzeroth.lua', lua);
}