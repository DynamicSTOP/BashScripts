import path from 'path'
import fs from 'fs'
import {execSync} from "child_process";

const root = `/path/to/zip/folders`;

process.chdir(root);

const list = fs.readdirSync(root);

list.forEach(p => {
  if (!p.endsWith('.zip')) {
    return;
  }
  console.log(p);
  const parts = p.split('.');
  parts.pop();
  const name = parts.join('.');
  const newDir = path.join(root, name);
  if (!fs.existsSync(newDir)) {
    fs.mkdirSync(newDir);
  }
  const cmd = `unzip -n ./${p.replace(/ /g, '\\ ')} -d ./${name.replace(/ /g, '\\ ')}`;
  console.log(cmd);
  execSync(cmd);
})
