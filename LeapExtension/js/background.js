/*
- This code works in the background - inspect background page from the extension 
  manager to debug.

- It checks the current tab you are in and if it was on a ytb video 
  we execute the foreground script to track watchTime

- we need to make sure to excute script only once on each tab.

- We need to figure out why excuting foreground works on mac but not on windows
*/

console.log('from background');
chrome.tabs.onActivated.addListener(tab => {
    chrome.tabs.get(tab.tabId, current_tab_info => {
        console.log(current_tab_info.url);
        if(/^https:\/\/www\.youtube\.com\/watch/.test(current_tab_info.url)) {
            chrome.tabs.executeScript(null, {file: './js/foreground.js'}, () => console.log('foreground is injected'));
        }
    });
});


//this allows us to know if current tab was updated with the desired url.
chrome.tabs.onUpdated.addListener(function(tabid, changeinfo, tab) {
    var url = tab.url;
    if (url !== undefined && changeinfo.status == "complete") {
        console.log(url);
        if (/^https:\/\/www\.youtube\.com\/watch/.test(tab.url)) {
            chrome.tabs.executeScript(null, {file: './js/foreground.js'}, () => console.log('foreground is injected'));
        }  
    }
});


