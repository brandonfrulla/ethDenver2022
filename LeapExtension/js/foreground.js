/*
- This code works in the foreground - inspect ytb page for example to debug.
- This code handles tracking watch time on ytb
- we need to figure out a way to store the totalWatchTime 
  in our database after certain events.
*/

console.log('from foreground');
var totalWatchTime = 0;
var startTime, endTime;

//get the HTMLMediaElement from ytb page.
var video = document.querySelector('video');
console.log("is the vid paused? " + video.paused);

//this helps us identify if this video is live or not on ytb
var liveBadge = document.querySelector('.ytp-live-badge');
var live = liveBadge && !liveBadge.getAttribute('disabled');
console.log("is this video live? " + live);

if(live) {
    if(!video.paused) {
        startTime = performance.now();
    }
    
    video.onplaying = function() {
        console.log("PLAYING");
        startTime = performance.now();
    };
    
    video.onpause = function() {
        console.log("STOPPED");
        endTime = performance.now();
        var timeDiff = endTime - startTime; 
        timeDiff /= 1000;
        var seconds = Math.round(timeDiff);
        totalWatchTime += seconds;
        console.log("you watched for this amount of seconds: " + seconds);
        console.log("this is your total watchtime in seconds so far: " + totalWatchTime);
    }
}








