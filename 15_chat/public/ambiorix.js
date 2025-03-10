// default insecure
let protocol = 'ws://';

// upgrade if secure
if (window.location.protocol == "https:")
  protocol = 'wss://';

// get websocket
let ambiorixSocket = new WebSocket(protocol + window.location.host);

// ambiorix Websocket
class Ambiorix {
  constructor() {
    this.onOpen = () => { };
    this.onClose = () => { };
    this.onError = (error) => { console.error(error) };
    this._handlers = new Map();
  }
  // send
  static send(name, message) {

    // build message
    let msg = { name: name, message: message, isAmbiorix: true };

    ambiorixSocket.send(JSON.stringify(msg));

  }

  onopen(fn) {
    this.onOpen = fn;
  }

  onclose(fn) {
    this.onClose = fn;
  }

  onerror(fn) {
    this.onError = fn;
  }

  start() {
    var that = this;
    ambiorixSocket.onmessage = (msg) => {
      let msgParsed = JSON.parse(msg.data);

      if (!msgParsed.isAmbiorix)
        return;

      if (that._handlers.has(msgParsed.name)) {
        that._handlers.get(msgParsed.name)(msgParsed.message);
      }
    }

    ambiorixSocket.onopen = this.onOpen;
    ambiorixSocket.onclose = this.onClose;
    ambiorixSocket.onerror = this.onError;
  }
  // receiver
  receive(name, fun) {
    this._handlers.set(name, fun)
  }
}

// helper function to parseCookies
// parseCookie(document.cookie);
const parseCookie = str => {
  if (str == "")
    return {};

  return str
    .split(';')
    .map(v => v.split('='))
    .reduce(
      (acc, v) => {
        acc[decodeURIComponent(v[0].trim())] = decodeURIComponent(v[1].trim());
        return acc;
      },
      {});
}
