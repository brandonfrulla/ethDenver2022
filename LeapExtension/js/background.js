console.log('from background');
chrome.tabs.onActivated.addListener(tab => {
    chrome.tabs.get(tab.tabId, current_tab_info => {
        if(/^https:\/\/www\.youtube/.test(current_tab_info.url)) {
            //TODO this runs successfuly but for some reason foreground.js does not get executed.
            chrome.tabs.executeScript(null, {file: './js/foreground.js'}, () => console.log('foreground is injected'));
        }
    });
});


