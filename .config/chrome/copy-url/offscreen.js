chrome.runtime.onMessage.addListener((msg, _sender, sendResponse) => {
  if (msg?.type !== "copy") return;
  const buf = document.getElementById("buf");
  buf.value = msg.text;
  buf.select();
  sendResponse(document.execCommand("copy"));
});
