#!/usr/bin/env node
const cli = require('cli');
const grpc = require('@grpc/grpc-js');
const protoLoader = require('@grpc/proto-loader');

const ERRORS = {
  multiple_args: 'Only one command is supported'
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

const target = "0.0.0.0:49153"
const client = new knowledgeProto.Presentation(
  target, grpc.credentials.createInsecure()
);

cli.parse(
  null,
  ['apply', 'withdraw', 'list']
);

const list = function () {
  let call = client.List({});

  call.on('data', (item) => { console.log(item) });
  call.on('end', () => { });
}

const withdraw = function () { }

const callback = (err, response) => {
  if (err) throw err;

  console.log('Response:', response);
  client.close();
}

const apply = function () {
  client.Register({ title: 'title' }, callback);
}

cli.main(function () {
  cli.setArgv(process.argv);

  if (cli.argc > 1) {
    cli.error(ERRORS.multiple_args)
  }

  switch (cli.args[0]) {
    case 'list':
      list();
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