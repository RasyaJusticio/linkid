const quraniIframe = document.getElementById("qurani-iframe");

const LANGUAGES = {
  id_id: "id_ID",
  en_us: "en_US",
  ra_ra: "ra_RA",
};

function postMessage(method, type, data) {
  quraniIframe.contentWindow.postMessage(
    {
      method,
      type,
      data,
    },
    QUR_APP_URL,
  );
}

window.addEventListener("message", function (event) {
  const eventMethod = event.data.method;
  const eventType = event.data.type;

  console.log("Received message from iframe:", event);

  if (!eventMethod || !eventType) {
    return;
  }

  if (eventMethod === "GET") {
    switch (eventType) {
      case "initial_data":
        postMessage("RESP", "initial_data", {
          user_id: QUR_USER_ID,
          language: LANGUAGES[QUR_LANGUAGE],
          appearance: QUR_APPEARANCE == "1" ? "dark" : "light",
          session: QUR_SESSION,
        });
        break;
    }
  }

  if (eventMethod === "POST") {
    const eventData = event.data.data;

    console.log("Received POST data:", eventData);

    if (!eventData) {
      return;
    }

    switch (eventType) {
      case "route_change": {
        const header = document.querySelector(".main-header");
        if (eventData.path === "/" || eventData.path === "/home") {
          header.classList.remove("hidden");
        } else {
          header.classList.add("hidden");
        }
        break;
      }
    }
  }
});
