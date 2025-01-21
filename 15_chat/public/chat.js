document.addEventListener("DOMContentLoaded", function() {
  const id = createId();

  const wss = new Ambiorix();
  wss.onopen(() => {
    console.info("Connecting");
  });

  wss.receive("chat", (msg) => {
    // it was sent by me
    if (msg.id == id) return;
    insertLeft(msg.text);
  });

  wss.onclose(() => {
    console.error("Disconnected");
  });

  wss.start();

  handleChat(id);
});

const createId = () => {
  return Math.random().toString(16).slice(2);
}

const handleChat = (id) => {
  const btn = document.querySelector("#send");
  btn.addEventListener("click", (_event) => {
    const tgt = document.querySelector("#message")
    const text = tgt.value;
    tgt.value = "";

    if (!text || text == "") return;

    insertRight(text);
    Ambiorix.send("chat", { text: text, id: id });
  });

  const query = document.querySelector("#message");
  query.addEventListener("keydown", (event) => {
    if (event.key != "Enter") return;

    const btn = document.querySelector("#send");
    btn.click();
  })
}

const insertLeft = (message) => {
  document.querySelector("#chat-list").insertAdjacentHTML("beforeend", chatLeft(message))
}

const insertRight = (message) => {
  document.querySelector("#chat-list").insertAdjacentHTML("beforeend", chatRight(message))
}

const chatLeft = (message) => {
  return `<section class="message -left">
    <i class="nes-bcrikko"></i>
    <div class="nes-balloon from-left">
      <p>${message}</p>
    </div>
  </section>`;
}

const chatRight = (message) => {
  return `<section class="message -right">
    <div class="nes-balloon from-right">
      <p>${message}</p>
    </div>
    <i class="nes-bcrikko"></i>
  </section>`;
}
