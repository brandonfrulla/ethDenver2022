document.getElementById('twitch-sign-in').addEventListener('click', function () {
    chrome.runtime.sendMessage({ message: 'login-twitch' }, function (response) {
        if (response.message === 'success') {
            console.log("we signed in using twitch");
        } 
    });
});

document.getElementById('ytb-sign-in').addEventListener('click', function () {
    chrome.runtime.sendMessage({ message: 'login-ytb' }, function (response) {
        if (response.message === 'success') {
            console.log("we signed in using ytb");
        } 
    });
});
