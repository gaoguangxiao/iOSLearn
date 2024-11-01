var nativeBridge = new Object();

nativeBridge.postMessage = function(params) {
    return window.webkit.messageHandlers.postMessage.postMessage({params});
}
