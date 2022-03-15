#!/usr/bin/env node
var cli = require('cli');

const multiArgError = 'Only one command is supported';

cli.parse(
  null,
  ['apply', 'withdraw', 'list']
);

const install = function () {
  console.log("installing");
}

const apply = function () {
  console.log("apply");
}

const withdraw = function () {
  console.log("withdraw");
}

cli.main(function () {
  cli.setArgv(process.argv);

  if (cli.argc > 1) { cli.error(multiArgError) }
  switch (cli.args[0]) {
    case 'list':
      install();
      break;
    case 'apply':
      apply();
      break;
    case 'withdraw':
      withdraw();
      break;
    default:
      console.log("never in here")
  }
})