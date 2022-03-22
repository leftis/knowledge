#!/usr/bin/env node

const os = require("os");
const cli = require('cli');
const clc = require("cli-color");
const grpc = require('@grpc/grpc-js');
const protoLoader = require('@grpc/proto-loader');

const ERRORS = {
  TITLE_IS_MISSING: 'Title of your presentation is missing',
  ID_OF_PRESENTATION_IS_MISSING: 'Please supply id of presentation to withdraw, you can only withdraw yours',
  NO_SUCH_COMMAND: 'There is no such command, please run `knowledge --help`'
};

const PROTO_PATH = '../protos/knowledge.proto';

const packageDefinition = protoLoader.loadSync(
  PROTO_PATH,
  {
    keepCase: true,
    longs: String,
    enums: String,
    defaults: true,
    oneofs: true
  });
const knowledgeProto = grpc.loadPackageDefinition(packageDefinition).knowledge;

const target = "0.0.0.0:50051"
const client = new knowledgeProto.Presentation(
  target, grpc.credentials.createInsecure()
);

cli.parse(
  null,
  ['apply', 'withdraw', 'list']
);

const list = function () {
  let call = client.List({});

  call.on('data', (item) => {
    var d = new Date(item.presented_at * 1000); // The 0 there is the key, which sets the date to the epoch
    console.log(`ID: ${clc.magentaBright(item.id)} title: ${clc.green(item.title)} status: ${clc.blue(item.status)} on ${d.toLocaleString()}`);
  });
  call.on('end', () => { });
}

const withdraw = function (id, author) {
  client.Withdraw({ id, author }, () => {
    console.log(`Successfully deleted ${clc.red(id)}`)
  });
}

const callback = (err, response) => {
  if (err) throw err;

  console.log('Registered presentation:', clc.red(response.title));
  client.close();
}

const apply = function (title, author) {
  client.Register({ title, author }, callback);
}

cli.main(function () {
  cli.setArgv(process.argv);

  const command = cli.args[0];

  switch (command) {
    case 'list':
      list();
      break;
    case 'apply':
      if (!cli.args[1]) {
        cli.error(ERRORS.TITLE_IS_MISSING);
        return;
      }
      apply(cli.args[1], os.hostname());
      break;
    case 'withdraw':
      if (!cli.args[1]) {
        cli.error(ERRORS.ID_OF_PRESENTATION_IS_MISSING);
        return;
      }
      withdraw(cli.args[1], os.hostname());
      break;
    default:
      cli.error(ERRORS.NO_SUCH_COMMAND);
  }
})