class Music {
    constructor() {
        this.playlist = config;
        this.currentSong = 0;
        this.sound = null;
    }

    getState() {
        return !this.sound.paused;
    }

    toggle(state) {
        if ( state === "play" ) {
            this.sound.volume = 0.5;
            this.sound.play();
        }
        if ( state === "pause" ) {
            this.sound.pause();
        }
    }

    start() {
        this.sound = document.createElement("audio");

        let sourceOf = document.createElement("source");
        sourceOf.src = "music/" + this.playlist[this.currentSong].file;
        this.sound.appendChild(sourceOf);
        
        this.sound.load();
        this.sound.volume = 0.5;
        this.sound.play();
    }

    pause = () => {
        this.sound.pause();
    }

    forward = () => {
        this.currentSong = this.currentSong + 1;

        this.sound.src = "music/" + this.playlist[this.currentSong].file;
        
        this.sound.load();
        this.sound.volume = 0.5;
        this.sound.play();
    }

    backward = () => {
        this.currentSong = this.currentSong - 1;

        this.sound.src = "music/" + this.playlist[this.currentSong].file;
        
        this.sound.load();
        this.sound.volume = 0.5;
        this.sound.play();
    }

    getSong = () => {
        return this.playlist[this.currentSong].name;
    }
}

let Sound = new Music();

$( document ).ready(() => {
    Sound.start();

    if (Sound.getState()) {
        $(".play").html(`<i class="fas fa-pause"></i>`);
    }
    else {
        $(".play").html(`<i class="fas fa-play"></i>`);
    }

    $(".music-song").html(`<span style="color: lightblue">"${Sound.getSong()}"</span> is playing...`);
});

$(".play").click(() => {
    if (!Sound.getState()) {
        Sound.toggle("play");
        $(".play").html(`<i class="fas fa-pause"></i>`);
    }
    else {
        Sound.toggle("pause");
        $(".play").html(`<i class="fas fa-play"></i>`);
    }

    $(".music-song").html(`<span style="color: lightblue">"${Sound.getSong()}"</span> is playing...`);
});

$(".forward").click(() => {
    Sound.forward();

    $(".music-song").html(`<span style="color: lightblue">"${Sound.getSong()}"</span> is playing...`);
});

$(".backward").click(() => {
    Sound.backward();

    $(".music-song").html(`<span style="color: lightblue">"${Sound.getSong()}"</span> is playing...`);
});