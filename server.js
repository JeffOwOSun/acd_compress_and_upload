"use strict";
require('shelljs/global');
var path = require('path');
var os = require('os');
//implement the server side using js
if (!which('acd_cli')) {
  echo('Sorry, please first install acd_cli');
  exit(1);
}

let args = process.argv.slice(2);
if (args.length < 2) {
  echo(`USAGE: ${path.basename(process.argv[0])} ${path.basename(process.argv[1])} LOCAL_DIR REMOTE_DIR`);
  exit(1);
}

const local_dir = args[0];
const project_name = os.basename(local_dir);
const remote_dir = args[1];
const volume_size = "10g";

//first create a working dir
const working_dir = `${os.tmpdir()}/acd_streamline_upload_download`;
if (!test('-d', working_dir)) {
  mkdir('-p', working_dir);
}

//create an empty project dir
const project_dir = `${working_dir}/${project_name}`;
if (!test('-d', project_dir)) {
  mkdir('-p', project_dir);
} else {
  rm('-rf', `${project_dir}/*`);
}

//compress the files
exec(`7z a -mx0 -v${volume_size} ${project_dir}/${project_name}.7z ${local_dir}`)

echo(local_dir, remote_dir, volume_size, working_dir);
