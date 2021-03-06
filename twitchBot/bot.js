const tmi = require('tmi.js');

// Define configuration options
// we need to get Daniel to set this data up in a .file and pull it from a file reader
const opts = {
  identity: {
    username: null,
    password: null
  },
  channels: [
    null
  ]
};

// Create a client with our options
const client = new tmi.client(opts);

// Register our event handlers (defined below)
client.on('message', onMessageHandler);
client.on('connected', onConnectedHandler);

// Connect to Twitch:
client.connect();

// Called every time a message comes in
function onMessageHandler (target, context, msg, self) {
  if (self) { return; } // Ignore messages from the bot

  // Remove whitespace from chat message
  const commandName = msg.trim();

  // If the command is known, let's execute it
  if (commandName === '!claim') {
    const viewTime = getViewTime(target);
    console.log(`* Executed ${commandName} command`);
  } else {
    console.log(`* Unknown command ${commandName}`);
  }
}

// Function called when the "claim" command is issued
function getViewTime (target) {
  // Twitch API / json parsing magic
  return 1;
}

// Called every time the bot connects to Twitch chat
function onConnectedHandler (addr, port) {
  console.log(`* Connected to ${addr}:${port}`);
}