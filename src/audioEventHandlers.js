'use strict';

var Alexa = require('alexa-sdk');
var audioData = require('./audioAssets');
var constants = require('./constants');

// Binding audio handlers to PLAY_MODE State since they are expected only in this mode.
var audioEventHandlers =  {
    'PlaybackStarted' : function () {
        /*
         * AudioPlayer.PlaybackStarted Directive received.
         * Confirming that requested audio file began playing.
         * Storing details in dynamoDB using attributes.
         */
        console.log("Playback started");        
        this.response.audioPlayerClearQueue('CLEAR_ENQUEUED');
        this.emit(':responseReady');
    },
    'PlaybackFinished' : function () {
        /*
         * AudioPlayer.PlaybackFinished Directive received.
         * Confirming that audio file completed playing.
         * Storing details in dynamoDB using attributes.
         */
        console.log("Playback finished");
        this.response.audioPlayerClearQueue('CLEAR_ENQUEUED');
        this.emit(':responseReady');
    },
    'PlaybackStopped' : function () {
        /*
         * AudioPlayer.PlaybackStopped Directive received.
         * Confirming that audio file stopped playing.
         * Storing details in dynamoDB using attributes.
         */
        console.log("Playback stopped");
    },
    'PlaybackNearlyFinished' : function () {
        console.log("Playback nearly finished");
    },
    'PlaybackFailed' : function () {
        //  AudioPlayer.PlaybackNearlyFinished Directive received. Logging the error.
        console.log("Playback Failed : %j", this.event.request.error);
        this.context.succeed(true);
    }
};

module.exports = audioEventHandlers;
